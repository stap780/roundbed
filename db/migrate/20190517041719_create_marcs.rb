class CreateMarcs < ActiveRecord::Migration[5.2]
  def change
    create_table :marcs do |t|
      t.string :sku
      t.string :title
      t.string :sdesc
      t.string :desc
      t.decimal :cprice
      t.decimal :price
      t.string :qt
      t.string :image

      t.timestamps null: false
    end
  end
end
