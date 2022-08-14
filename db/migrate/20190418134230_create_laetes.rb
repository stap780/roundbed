class CreateLaetes < ActiveRecord::Migration
  def change
    create_table :laetes do |t|
      t.string :lid
      t.string :url
      t.string :title
      t.string :sku
      t.decimal :price
      t.string :qt
      t.string :razmer_eu
      t.string :razmer_ru
      t.string :uzor
      t.string :cvet
      t.string :sostav
      t.string :image

      t.timestamps null: false
    end
  end
end
