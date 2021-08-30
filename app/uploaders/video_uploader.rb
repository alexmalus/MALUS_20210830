# This is a subclass of Shrine base that will be further configured for it's requirements.
# This will be included in the model to manage the file.

require 'streamio-ffmpeg'
require 'tempfile'

# Dev note: inspired by https://stackoverflow.com/questions/56502711/use-shrine-to-upload-video-files-and-generate-thumbnails
class VideoUploader < Shrine
  ALLOWED_TYPES  = %w[video/mp4 video/quicktime].freeze # MP4 and MOV only.
  MAX_SIZE       = 200 * 1024 * 1024 # 200 MB

  plugin :add_metadata
  plugin :validation_helpers
  plugin :processing
  plugin :versions
  plugin :delete_raw
  plugin :pretty_location

  add_metadata do |io, _context|
    movie = Shrine.with_file(io) { |file| FFMPEG::Movie.new(file.path) }

    { 'duration' => movie.duration,
      'bitrate' => movie.bitrate,
      'resolution' => movie.resolution,
      'frame_rate' => movie.frame_rate }
  end

  process(:store) do |io, _context|
    versions = { original: io }

    io.download do |original|
      small_thumb = Tempfile.new(%w[small_thumb .jpg], binmode: true)
      medium_thumb = Tempfile.new(%w[medium_thumb .jpg], binmode: true)
      large_thumb = Tempfile.new(%w[large_thumb .jpg], binmode: true)

      movie = FFMPEG::Movie.new(original.path)
      movie.screenshot(small_thumb.path, seek_time: 1, resolution: '64x64')
      movie.screenshot(medium_thumb.path, seek_time: 1, resolution: '128x128')
      movie.screenshot(large_thumb.path, seek_time: 1, resolution: '256x256')

      [small_thumb, medium_thumb, large_thumb].each(&:open) # refresh file descriptors

      versions.merge!(small_thumb: small_thumb, medium_thumb: medium_thumb, large_thumb: large_thumb)
    end

    versions
  end

  Attacher.validate do
    validate_max_size MAX_SIZE.megabyte, message: "is too large (max is #{MAX_SIZE} MB)"
    validate_mime_type_inclusion ALLOWED_TYPES
  end
end
