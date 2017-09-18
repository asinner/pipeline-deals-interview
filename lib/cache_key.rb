# CacheKey is the authoritative source for creating cache keys.
module CacheKey
  def self.all_deals(args)
    'pipeline_deals/deals/all/' + args.to_param
  end
end