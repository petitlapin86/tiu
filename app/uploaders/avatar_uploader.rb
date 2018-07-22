class AvatarUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    "data:image/jpeg;base64,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"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
