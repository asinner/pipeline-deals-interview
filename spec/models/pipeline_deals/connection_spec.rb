# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PipelineDeals::Connection, type: :model do
  describe 'class' do
    it 'extends the ActiveResource::Connection class' do
      expect(PipelineDeals::Connection.superclass).to eq(ActiveResource::Connection)
    end
  end
end
