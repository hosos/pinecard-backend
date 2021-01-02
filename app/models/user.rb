# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  telegram_id :string
#
class User < ApplicationRecord
end
