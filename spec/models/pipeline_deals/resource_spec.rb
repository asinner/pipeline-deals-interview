require 'rails_helper'

RSpec.describe PipelineDeals::Resource, type: :model do
  describe 'class' do
    it 'extends the AciveResource::Base class' do
      expect(PipelineDeals::Resource.superclass).to eq(ActiveResource::Base)
    end

    it 'uses the PipelineDeals::Connection class' do
      expect(PipelineDeals::Resource.connection_class).to eq(PipelineDeals::Connection)
    end

    it 'uses the PipelineDeals::Connection class' do
      expect(PipelineDeals::Resource.connection_class).to eq(PipelineDeals::Connection)
    end
  end
  
  describe 'api' do
    it 'responds_to site' do
      expect(PipelineDeals::Resource).to respond_to(:site)
    end
  end
  
  describe '#site' do
    it 'returns the PipelineDeals API url' do
      expect(PipelineDeals::Resource.site.to_s).to eq('https://app.pipelinedeals.com/api/v3')
    end
  end
end
