# == Schema Information
#
# Table name: hash_tags
#
#  id          :bigint           not null, primary key
#  holder_type :string           not null
#  value       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  holder_id   :bigint           not null
#
# Indexes
#
#  index_hash_tags_on_holder  (holder_type,holder_id)
#
class HashTag < ApplicationRecord
  belongs_to :holder, polymorphic: true
end
