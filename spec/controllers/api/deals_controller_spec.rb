# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::DealsController, type: :controller do
  describe 'GET index' do
    before :each do
      Rails.cache.clear
      @entries = [{ id: 1 }]
      # Top level entry is removed
      @mock = { body: { entries: @entries } }
      stub_request(:get, 'https://app.pipelinedeals.com/api/v3/deals.json?api_key=G5mZccexXgchNkAYOBlQ')
        .to_return(status: 200, body: @mock.to_json)
    end

    it 'retrieves a list of deals' do
      get :index, format: :json
      expect(JSON.parse(response.body).deep_symbolize_keys).to eq(deals: @entries)
    end

    it 'renders JSON format' do
      get :index, format: :json
      expect(response.content_type).to eq('application/json')
    end

    it 'returns a success level status code' do
      get :index, format: :json
      expect(response.success?).to be(true)
    end
  end
end
