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
class MyCardSerializer < ActiveModel::Serializer
  attributes MyCard.attribute_names

  has_many :emails, if: -> { show_details? }
  has_many :phones, if: -> { show_details? }
  has_many :addresses, if: -> { show_details? }
  has_many :website_urls, if: -> { show_details? }
  has_many :social_urls, if: -> { show_details? }
  has_many :hash_tags, if: -> { show_details? }
  has_many :photos
  has_one :logo

  def show_details?
    @instance_options[:show_details]
  end

  def photos
    if @instance_options[:show_details]
      object.photos
    else
      object.photos.first(1)
    end
  end
end
