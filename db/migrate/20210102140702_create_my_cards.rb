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
      t.references :user, null: false, foreign_key: true
      t.boolean :public, default: false
      t.boolean :primary, default: false
      t.timestamps
    end
  end
end
