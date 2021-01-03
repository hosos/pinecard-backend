# == Schema Information
#
# Table name: phones
#
#  id         :bigint           not null, primary key
#  category   :integer          default("mobile")
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  my_card_id :bigint           not null
#
# Indexes
#
#  index_phones_on_my_card_id  (my_card_id)
#
# Foreign Keys
#
#  fk_rails_...  (my_card_id => my_cards.id)
#
class Phone < ApplicationRecord
  belongs_to :my_card

  enum category: { mobile: 0, work: 1, home: 2, pager: 3, work_fax: 4, home_fax: 5, other: 6 }
end
