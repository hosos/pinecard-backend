# == Schema Information
#
# Table name: photos
#
#  id          :bigint           not null, primary key
#  category    :string           default("photo")
#  holder_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  holder_id   :bigint           not null
#
# Indexes
#
#  index_photos_on_category  (category)
#  index_photos_on_holder    (holder_type,holder_id)
#
class Photo < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :image

  def url
    url_for(image)
  end

  def upload_from_url(photo_url)
    url = URI.parse(photo_url)
    filename = File.basename(url.path)
    file = URI.open(url)
    image.purge if image.attached?
    image.attach(io: file, filename: filename)

    self
  end
end
