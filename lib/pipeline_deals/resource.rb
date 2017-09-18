module PipelineDeals
  # All API resources should inherit this class as it will provide shared 
  # functionality such as setting default request parameters (ex. api_key)
  class Resource < ActiveResource::Base

    # In order to add default request parameters we will use our own 
    # connection class.
    self.connection_class = Connection

    # Since all Resource class will inherit this class, we can put the 
    # site here. In the future, it will need to dynamically lookup
    # the api_version from the PipelineDeals module.
    self.site = 'https://app.pipelinedeals.com/api/v3'
  end
end