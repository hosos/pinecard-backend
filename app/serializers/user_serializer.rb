# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UserSerializer < ActiveModel::Serializer
  attributes User.attribute_names + %i[token]

  has_one :telegram_account
end
