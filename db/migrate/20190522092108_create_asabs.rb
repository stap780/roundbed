class CreateAsabs < ActiveRecord::Migration[5.2]
  def change
    create_table :asabs do |t|
      t.string :aid
      t.string :sku
      t.string :title
      t.string :sdesc
      t.string :desc
      t.decimal :cprice
      t.decimal :price
      t.string :qt
      t.string :image
      t.string :sostav

      t.timestamps null: false
    end
  end
end
