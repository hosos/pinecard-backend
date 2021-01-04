class CreateMyCards < ActiveRecord::Migration[6.1]
  def change
    create_table :my_cards do |t|
      t.integer :name_prefix
      t.string :fullname
      t.text :description
      t.string :organization
      t.string :title
      t.string :role
      t.integer :gender
      t.date :birthday
      t.integer :daily_send_request_quota, default: 10
      t.integer :daily_receive_request_quota, default: 10
      t.integer :category, default: 0
      t.references :user, null: false, foreign_key: true
      t.boolean :public, default: false
      t.boolean :primary, default: false
      t.boolean :auto_accept_request, default: false
      t.timestamps
    end
  end
end
