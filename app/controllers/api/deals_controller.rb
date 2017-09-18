class Api::DealsController < ApplicationController
  def index
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
end
