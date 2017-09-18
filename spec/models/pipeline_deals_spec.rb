require 'rails_helper'

RSpec.describe PipelineDeals, type: :model do
  describe 'api' do
    it 'responds to api_key' do
      expect(PipelineDeals).to respond_to(:api_key)
    end

    it 'responds to api_key=' do
      expect(PipelineDeals).to respond_to(:api_key=)
    end
  end
end
