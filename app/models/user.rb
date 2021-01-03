# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_one :telegram_account, dependent: :destroy
  has_many :my_cards, dependent: :destroy
  has_one :primary_card, -> { where(primary: true) }, class_name: 'MyCard', dependent: :destroy

  accepts_nested_attributes_for :telegram_account, allow_destroy: false

  before_validation :init_primary_card, on: :create

  def token
    Jwt::Crypter.encode(user_id: id)
  end

  def init_primary_card
    primary_card = my_cards.build(primary: true, fullname: telegram_account.fullname)
    primary_card.social_urls.build(category: :telegram).assign_with_username(telegram_account.username)
    primary_card.photos.build.upload_from_url(telegram_account.photo_url) if telegram_account.photo_url
  end
end
