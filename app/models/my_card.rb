# == Schema Information
#
# Table name: my_cards
#
#  id                          :bigint           not null, primary key
#  auto_accept_request         :boolean          default(FALSE)
#  birthday                    :date
#  category                    :integer          default("intro")
#  daily_receive_request_quota :integer          default(10)
#  daily_send_request_quota    :integer          default(10)
#  description                 :text
#  fullname                    :string
#  gender                      :integer
#  name_prefix                 :integer
#  organization                :string
#  primary                     :boolean          default(FALSE)
#  public                      :boolean          default(FALSE)
#  role                        :string
#  title                       :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  user_id                     :bigint           not null
#
# Indexes
#
#  index_my_cards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class MyCard < ApplicationRecord
  belongs_to :user

  enum name_prefix: { mr: 0, mrs: 1, miss: 2, dr: 3 }
  enum gender: { male: 0, female: 1, other: 2 }
  enum category: { intro: 0, dating: 1, event: 2, product: 3, service: 4 }

  has_many :emails, dependent: :destroy
  has_many :phones, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :website_urls, dependent: :destroy
  has_many :social_urls, dependent: :destroy
  has_many :hash_tags, as: :holder, dependent: :destroy
  has_many :photos, -> { where(category: :photo) }, class_name: 'Photo', as: :holder, dependent: :destroy
  has_one :logo, -> { where(category: :logo) }, class_name: 'Photo', as: :holder, dependent: :destroy

  has_many :sent_contact_requests, class_name: 'ContactRequest', foreign_key: 'owner_card_id', dependent: :destroy
  has_many :received_contact_requests, class_name: 'ContactRequest', foreign_key: 'friend_card_id', dependent: :destroy

  accepts_nested_attributes_for :emails, allow_destroy: true
  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :website_urls, allow_destroy: true
  accepts_nested_attributes_for :social_urls, allow_destroy: true
  accepts_nested_attributes_for :hash_tags, allow_destroy: true
  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :logo, allow_destroy: true

  validates :fullname, presence: true
end
