class TinymceAssetsController < ApplicationController
  protect_from_forgery with: :exception
  respond_to :json

  def create
    uploader = TinymceUploader.new
    uploader.store!(params[:file])

    render json: {
      image: {
        url: uploader.url
      }
    }, content_type: "text/html"
  end
end
