require 'rails_helper'

RSpec.describe CacheKey, type: :model do
  describe 'implementation' do
    it 'has an all_deals method' do
      expect(CacheKey).to respond_to(:all_deals)
    end
  end

  describe 'all_deals' do
    it 'returns cache keys for different hashes with same key/values' do
      key1 = CacheKey.all_deals({per_page: 2, page: 2})
      key2 = CacheKey.all_deals({page: 2, per_page: 2})
      expect(key1).to eq(key2)
    end

    it 'returns different cache keys for different hashes with different key/values' do
      key1 = CacheKey.all_deals({per_page: 2, page: 2})
      key2 = CacheKey.all_deals({page: 2, per_page: 10})
      expect(key1).to_not eq(key2)
    end
  end
end
