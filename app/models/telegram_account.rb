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
require 'open-uri'

class TelegramAccount < ApplicationRecord
  has_one :avatar, -> { where(category: :logo) }, class_name: 'Photo', as: :holder, dependent: :destroy

  belongs_to :user

  def fullname
    "#{first_name} #{last_name}"
  end

  def update_avatar_from_url(photo_url)
    avatar&.destroy! if avatar
    build_avatar.upload_from_url(photo_url).save! if photo_url
  end

  def self.create_or_login_with(tg_auth_data)
    tg_auth_data = tg_auth_data.deep_transform_keys(&:to_sym)
    account = TelegramAccount.find_by(tg_auth_data[:telegram_id])
    account_params = tg_auth_data.except(:auth_date, :id, :hash).merge(telegram_id: tg_auth_data[:id])

    need_update_photo = account&.photo_url != tg_auth_data[:photo_url]

    if account
      account.update!(account_params)
    else
      user = User.create!(telegram_account_attributes: account_params)
      account = user.telegram_account
    end

    account.update_avatar_from_url(tg_auth_data[:photo_url]) if need_update_photo

    account
  end
end
