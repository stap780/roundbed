class CreateCleos < ActiveRecord::Migration
  def change
    create_table :cleos do |t|
      t.string :sku
      t.string :title
      t.string :sdesc
      t.string :desc
      t.decimal :cprice
      t.decimal :price
      t.string :qt
      t.string :image
      t.string :barcode
      t.string :dizain
      t.string :cvet
      t.string :tema
      t.string :okras
      t.string :otdelka
      t.string :zast
      t.string :kvopred
      t.string :tkan
      t.string :plotnost
      t.string :sostav
      t.string :obrazmer
      t.string :pr_razmer
      t.string :obem
      t.string :ves
      t.string :razmer_upak
      t.string :vid_upak

      t.timestamps null: false
    end
  end
end
