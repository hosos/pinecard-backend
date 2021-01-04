class CreateTelegramAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :telegram_accounts do |t|
      t.string :telegram_id
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :photo_url

      t.integer :my_card_quota, default: 20
      t.integer :contact_quota, default: 100

      t.timestamps
    end
  end
end
