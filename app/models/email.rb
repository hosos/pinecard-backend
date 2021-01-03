# == Schema Information
#
# Table name: emails
#
#  id         :bigint           not null, primary key
#  category   :integer          default("home")
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  my_card_id :bigint           not null
#
# Indexes
#
#  index_emails_on_my_card_id  (my_card_id)
#
# Foreign Keys
#
#  fk_rails_...  (my_card_id => my_cards.id)
#
class Email < ApplicationRecord
  belongs_to :my_card

  enum category: { home: 0, work: 1, other: 2 }
end
