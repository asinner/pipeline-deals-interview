module PipelineDeals
  # DealCollection wraps the ActiveResource::Collection object and tells the 
  # Resource class how to unwrap API responses to access the collection.
  # If all collection endpoints use the same schema, then this can safely
  # be abstracted to a more generically named module.
  class DealCollection < ActiveResource::Collection
    def initialize(parsed = {})
      @elements = parsed['entries']
    end
  end
end