class TestTrack::SplitRegistry
  include TestTrack::TestTrackModel

  CACHE_KEY = 'test_track_split_registry'

  collection_path '/api/split_registry'

  def self.fake_instance_attributes(_)
    {
      time: { hammertime: 100, clobberin_time: 0 },
      blue_button: { true: 50, false: 50 }
    }
  end

  def self.instance
    # TODO: FakeableHer needs to make this faking a feature of `get`
    if ENV['TEST_TRACK_ENABLED']
      get('/api/split_registry')
    else
      new(fake_instance_attributes(nil))
    end
  end

  def self.reset
    Rails.cache.delete(CACHE_KEY)
  end

  def self.to_hash
    Rails.cache.fetch(CACHE_KEY, expires_in: 5.seconds) do
      instance.attributes
    end.freeze
  rescue *TestTrack::SERVER_ERRORS
    nil # if we can't get a split registry
  end
end
