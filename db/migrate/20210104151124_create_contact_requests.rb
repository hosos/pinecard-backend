class CreateContactRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_requests do |t|
      t.integer :status, default: 0
      t.text :message
      t.references :owner_card, null: false, foreign_key: { to_table: :my_cards }
      t.references :friend_card, null: false, foreign_key: { to_table: :my_cards }

      t.timestamps
    end
  end
end
