class PicturesController < ApplicationController

  def new
  end

  def create
    picture = Picture.new(pic_params)
    picture.save
    redirect_to dashboard_path
  end

  private

  def pic_params
    params.require(:picture).permit(:image, :imageable_id, :imageable_type)
  end

end
