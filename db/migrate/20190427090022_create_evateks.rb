class CreateEvateks < ActiveRecord::Migration[5.2]
  def change
    create_table :evateks do |t|
      t.string :eid
      t.string :url
      t.string :title
      t.string :sku
      t.decimal :cprice
      t.string :sdesc
      t.string :desc
      t.decimal :price
      t.decimal :oprice
      t.string :qt
      t.string :razmer_eu
      t.string :razmer_ru
      t.string :uzor
      t.string :cvet
      t.string :sostav
      t.string :weight
      t.string :vendor
      t.string :col
      t.string :country
      t.string :image

      t.timestamps null: false
    end
  end
end
