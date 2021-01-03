# == Schema Information
#
# Table name: social_urls
#
#  id         :bigint           not null, primary key
#  category   :integer          default("telegram")
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  my_card_id :bigint           not null
#
# Indexes
#
#  index_social_urls_on_my_card_id  (my_card_id)
#
# Foreign Keys
#
#  fk_rails_...  (my_card_id => my_cards.id)
#
class SocialUrl < ApplicationRecord
  belongs_to :my_card

  enum category: { telegram: 0, facebook: 1, linked_in: 2, twitter: 3 }

  def assign_with_username(username)
    self.value = "https://t.me/#{username}" if telegram?
    self.value = "https://www.facebook.com/#{username}" if facebook?
    self.value = "https://www.linkedin.com/in/#{username}" if facebook?
    self.value = "https://www.twitter.com/#{username}" if twitter?
  end
end
