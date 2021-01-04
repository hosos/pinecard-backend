# == Schema Information
#
# Table name: telegram_accounts
#
#  id            :bigint           not null, primary key
#  contact_quota :integer          default(100)
#  first_name    :string
#  last_name     :string
#  my_card_quota :integer          default(20)
#  photo_url     :string
#  username      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  telegram_id   :string
#  user_id       :bigint           not null
#
# Indexes
#
#  index_telegram_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class TelegramAccountSerializer < ActiveModel::Serializer
  attributes TelegramAccount.attribute_names

  has_one :avatar
end
