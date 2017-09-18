require 'rails_helper'

RSpec.describe PipelineDeals::DealCollection, type: :model do
  describe 'class' do
    it 'extends the ActiveResource::Collection class' do
      expect(PipelineDeals::DealCollection.superclass).to eq(ActiveResource::Collection)
    end
  end

  describe 'initialization' do
    it 'returns entries' do
      @data = {"entries" => []}
      @collection = PipelineDeals::DealCollection.new(@data)
      expect(@collection).to eq(@data['entries'])
    end
  end
end
