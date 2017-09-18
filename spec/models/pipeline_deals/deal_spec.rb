require 'rails_helper'

RSpec.describe PipelineDeals::Deal, type: :model do
  describe 'class' do
    it 'extends the PipelineDeal::Resource class' do
      expect(PipelineDeals::Deal.superclass).to eq(PipelineDeals::Resource)
    end

    it 'uses the PipelineDeals::DealCollection as a parser' do
      expect(PipelineDeals::Deal.collection_parser).to eq(PipelineDeals::DealCollection)
    end
  end
end
