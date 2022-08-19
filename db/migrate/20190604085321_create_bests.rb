class CreateBests < ActiveRecord::Migration[5.2]
  def change
    create_table :bests do |t|
      t.string :sku
      t.string :title
      t.string :sdesc
      t.string :desc
      t.decimal :cprice
      t.decimal :price
      t.string :qt
      t.string :image
      t.string :sv_razmer
      t.string :p_razmer
      t.string :p_napolnit
      t.string :p_visota
      t.string :p_dlina
      t.string :p_shirina
      t.string :p_ves
      t.string :p_sostav
      t.string :p_osoben
      t.string :p_tipmatrasa
      t.string :p_garant
      t.string :p_forma

      t.timestamps null: false
    end
  end
end
