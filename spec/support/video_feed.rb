# frozen_string_literal: true

module VideoFeed
  FEEDS = { sample_video_feed: 'sample_960x540.mp4' }.freeze

  FEEDS.each do |method, filename|
    define_method(method) { load_sample filename }
  end

  def load_sample(filename)
    File.open("#{File.dirname(__FILE__)}/sample_feeds/#{filename}", "rb")
  end
end
