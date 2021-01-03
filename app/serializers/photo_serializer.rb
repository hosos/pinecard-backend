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
class PhotoSerializer < ActiveModel::Serializer
  attributes Photo.attribute_names + %i[url]
end
