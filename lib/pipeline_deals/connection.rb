# frozen_string_literal: true

module PipelineDeals
  # Connection inherits from the ActiveResource::Connection class. It will
  # override the methods necessary for adding default parameters to each
  # request.
  class Connection < ActiveResource::Connection
    private

      # Internally, ActiveResource::Connection calls this method in order
      # to send a network request. This method can be overridden to add
      # add our own logic. Parameters must be added differently per the
      # method being used. For example, GET, HEAD, & DELETE methods can't
      # contain a request body, so all parameters must go into the query
      # string. For everything else, the default parameters can be encoded
      # into the request body.
      def request(method, path, *arguments)
        case method
        when :get, :delete, :head
          path = path_with_defaults(path)
        else
          arguments = body_with_defaults(*arguments)
        end
        super(method, path, *arguments)
      end

      # body_with_defaults is used for any request that uses an HTTP request body
      # (eg. POST, PUT). It merges the default parameters in with the existing
      # request body. This assumes that all body encodings use JSON (which) is
      # fine for the PipelineDeals API since it solely relies on JSON.
      def body_with_defaults(*arguments)
        body = arguments.slice!(0)
        begin
          body = defaults.merge!(JSON.parse(body))
        rescue JSON::ParserError
          body = defaults
        end
        arguments.unshift(body)
      end

      # path_with_defaults merges the default parameters onto the query
      # string and returns the new path.
      def path_with_defaults(path)
        uri = URI.parse(path)
        query = uri.query || ''
        params = URI.decode_www_form(query)
        params = params.each_with_object(defaults) do |param, parameters|
          k, v = param
          parameters[k] = v
        end
        params.map { |k, v| [k, v] }
        uri.query = URI.encode_www_form(params)
        uri.to_s
      end

      def api_key
        PipelineDeals.api_key
      end

      # The default parameters added to each request.
      def defaults
        { api_key: api_key }
      end
  end
end
