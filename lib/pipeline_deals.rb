# frozen_string_literal: true

require 'pipeline_deals/resource'
require 'pipeline_deals/connection'
require 'pipeline_deals/collection/deal_collection'
require 'pipeline_deals/resources/deal'

# The PipelineDeals module will encapsulate all of the logic necessary for
# communicating with the PipelineDeals API.
module PipelineDeals
  class << self
    # Since PipelineDeals is a singleton, setting api_key is not a thread-safe
    # operation. It should be noted that end users should instead pass in
    # the api_key with every request instead for thread-safe operations.
    attr_accessor :api_key

    # add api_version here for now until the site versioning functionality
    # has been default.
    def api_version
      :v3
    end
  end
end
