# == Schema Information
#
# Table name: my_cards
#
#  id           :bigint           not null, primary key
#  birthday     :date
#  description  :text
#  fullname     :string
#  gender       :integer
#  name_prefix  :integer
#  organization :string
#  primary      :boolean          default(FALSE)
#  public       :boolean          default(FALSE)
#  role         :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_my_cards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class MyCardSerializer < ActiveModel::Serializer
  attributes MyCard.attribute_names

  has_many :emails
  has_many :phones
  has_many :addresses
  has_many :website_urls
  has_many :social_urls
  has_many :hash_tags
  has_many :photos
  has_one :logo
end
