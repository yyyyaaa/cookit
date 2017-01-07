require "image_processing/mini_magick"

class ImageUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :determine_mime_type
  plugin :remove_attachment
  plugin :store_dimensions
  plugin :validation_helpers
  plugin :pretty_location
  plugin :processing
  plugin :versions

  Attacher.validate do
    validate_max_size 20.megabytes, message: 'is too large (max is 20 MB)'
    validate_mime_type_inclusion ['image/jpeg', 'image/png']
  end

  process(:store) do |io|
    original = io.download
    normal = resize_to_limit!(original, 400, 400)
    thumb = resize_to_limit(normal, 200, 200)
    { original: io, thumb: thumb, normal: normal}
  end
end
