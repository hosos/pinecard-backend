class AddUserToTelegramAccounts < ActiveRecord::Migration[6.1]
  def change
    add_reference :telegram_accounts, :user, null: false, foreign_key: true
  end
end
