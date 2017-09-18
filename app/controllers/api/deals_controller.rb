# The Api::DealsController acts as a proxy for the PipelineDeals API. It 
# performs caching in order prevent rate limiting errors as well as 
# increase performance.
class Api::DealsController < ApplicationController
  def index
    # memoize the permitted parameters object
    @parameters = permitted_index_params
    
    # Since this API permits query parameters, it is important to ensure
    # the cache key reflects the data being retrieved. This method assumes
    # that permitted_index_params is deterministic.
    key = CacheKey.all_deals({
      version: PipelineDeals.api_version,
      params: @parameters
    })

    # Cache all results for better performance, avoid rate limiting errors,
    # and prevent abuse of the API. Although clientside aggregation can work
    # in this scenario, it is not ideal for reporting as it requires alot
    # of unnecessary overhead and uses paginated APIs. A better approach
    # is to perform the aggregation at the database layer. Additionally, 
    # the caching approach can work for a single server architecture, but 
    # for multi server architecture the caching should be backed by a network
    # cache such as a Redis cluster.
    @deals = Rails.cache.fetch(key, expires_in: index_expiration_length) do
      PipelineDeals::Deal.all({
        params: @parameters
      })
    end

    # For right now, only support JSON. In the future, we may expect to 
    # support multiple formats. If in the future, the API asserts the only
    # format supported is JSON then the serialization step can be moved to the 
    # cache layer.
    respond_to do |format|
      format.json { render json: { deals: @deals } }
    end
  end

  protected

    # permitted_index_params defines which parameters are allowed to be used
    # in querying the API.
    def permitted_index_params
      params.permit(
        :page, 
        :per_page, 
        :search_id, 
        :totals, 
        conditions: [
          :deal_id, 
          :deal_name, 
          :deal_percentage, 
          :deal_source, 
          :deal_owner, 
          :deal_value, 
          :deal_stage, 
          :exp_close, 
          :deal_created, 
          :deal_modified, 
          :deal_closed_time, 
          :person_full_name, 
          :person_phone, 
          :person_city, 
          :person_state, 
          :person_work_zip, 
          :person_zip, 
          :person_company_name, 
          :sort
        ]
      )
    end

    # Depending on the rate of change, this length can be 
    # modified to determine how often we should query the actual
    # API for the latest data. For right now, let's assume that a company's
    # data goes stale after 1 minute.
    def index_expiration_length
      60.seconds
    end
end
