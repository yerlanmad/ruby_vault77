class ImageHandler
  # Domain specific errors
  class ImageExtensionError < StandartError; end
  class ImageDimensionError < StandartError; end
  class ImageTooBigError < ImageDimensionError
    def message
      'Image is too big'
    end
  end
  class ImageTooSmallError < ImageDimensionError
    def message
      'Image is too small'
    end
  end

  def self.handle_upload(image)
    raise ImageTooBigError if image.size > 10.megabytes
    raise ImageTooSmallError if image.size < 100.kilobytes
    raise ImageExtensionError unless %w[JPG JPEG].include?(image.extension)

    # do stuff
  end
end

class ImageUploadController < ApplicationController
  def upload
    @image = params[:image]
    ImageHandler.handle_upload(@image)

    redirect_to :index, notice: 'Image upload success!'
  rescue ImageHandler::ImageDimensionError => e
    render 'edit', alert: "Error: #{e.message}"
  rescue ImageHandler::ImageExtensionError
    head :forbidden
  end
end
