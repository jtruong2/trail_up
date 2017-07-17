class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :imageable, :polymorphic => true

  def self.creat_many(params)
    raw_images = params[:images].map do |image|
      { imageable_id: params[:imageable_id], imageable_type: params[:imageable_type], image: image }
    end
    Picture.create(raw_images)
  end
end
