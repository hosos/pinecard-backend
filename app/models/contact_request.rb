# == Schema Information
#
# Table name: contact_requests
#
#  id             :bigint           not null, primary key
#  message        :text
#  status         :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  friend_card_id :bigint           not null
#  owner_card_id  :bigint           not null
#
# Indexes
#
#  index_contact_requests_on_friend_card_id  (friend_card_id)
#  index_contact_requests_on_owner_card_id   (owner_card_id)
#
# Foreign Keys
#
#  fk_rails_...  (friend_card_id => my_cards.id)
#  fk_rails_...  (owner_card_id => my_cards.id)
#
class ContactRequest < ApplicationRecord
  belongs_to :friend_card, class_name: 'MyCard'
  belongs_to :owner_card, class_name: 'MyCard'

  enum status: { pending: 0, approved: 1, rejected: 2 }
end
