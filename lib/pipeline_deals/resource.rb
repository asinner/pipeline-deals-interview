module PipelineDeals
  # All API resources should inherit this class as it will provide shared 
  # functionality such as setting default request parameters (ex. api_key)
  class Resource < ActiveResource::Base

    # In order to add default request parameters we will use our own 
    # connection class.
    self.connection_class = Connection
  end
end