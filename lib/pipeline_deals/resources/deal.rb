# frozen_string_literal: true

module PipelineDeals
  # The deal class acts as the client library that will interact with
  # the PipelineDeals deals API. Since the PipelineDeals API is RESTful, this
  # class will be supported by the Resource class.
  class Deal < Resource
    self.collection_parser = DealCollection
  end
end
