module PipelineDeals
  # The deal class acts as the client library that will interact with
  # the PipelineDeals deals API. Since the PipelineDeals API is RESTful, this
  # class will be supported by the ActiveResource::Base class.
  class Deal < ActiveResource::Base
    self.site = 'https://api.pipelinedeals.com/api/v3'
  end
end