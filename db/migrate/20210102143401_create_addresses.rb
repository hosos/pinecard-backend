class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :category, default: 0
      t.string :value
      t.references :my_card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
