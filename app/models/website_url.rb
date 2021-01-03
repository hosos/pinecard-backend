# == Schema Information
#
# Table name: website_urls
#
#  id         :bigint           not null, primary key
#  category   :integer          default("work")
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  my_card_id :bigint           not null
#
# Indexes
#
#  index_website_urls_on_my_card_id  (my_card_id)
#
# Foreign Keys
#
#  fk_rails_...  (my_card_id => my_cards.id)
#
class WebsiteUrl < ApplicationRecord
  belongs_to :my_card

  enum category: { work: 0, other: 1 }
end
