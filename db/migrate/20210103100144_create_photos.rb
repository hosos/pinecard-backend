class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :category, default: 'photo'
      t.references :holder, polymorphic: true, null: false

      t.timestamps

      t.index :category
    end
  end
end
