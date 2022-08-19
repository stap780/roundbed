class CreateInfas < ActiveRecord::Migration[5.2]
  def change
    create_table :infas do |t|
      t.string :fid
      t.string :sku
      t.string :barcode
      t.string :title
      t.string :desc
      t.string :feature
      t.decimal :costprice
      t.decimal :price
      t.string :qt
      t.string :image
      t.string :vendor
      t.string :model
      t.string :i_param
      t.string :cat

      t.timestamps null: false
    end
  end
end
