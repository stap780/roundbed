class CreateAlviteks < ActiveRecord::Migration
  def change
    create_table :alviteks do |t|
      t.string :aid
      t.string :sku
      t.string :title
      t.string :desc
      t.string :qt
      t.decimal :price
      t.decimal :mprice
      t.string :image
      t.string :cat
      t.string :col
      t.string :vendor
      t.string :country
      t.string :line
      t.string :razmer
      t.string :teplota
      t.string :podderjka
      t.string :razm_nav
      t.string :razm_podod
      t.string :razmer_prostini
      t.string :tip_prostini
      t.string :visota
      t.string :napolnitel
      t.string :napolnitel_chehla
      t.string :napolnitel_yadra
      t.string :ves_napolnitel
      t.string :ves_nopolnitel_chehla
      t.string :ves_napolnitel_yadra
      t.string :tkan
      t.string :sostav_tkan
      t.string :tip_zast
      t.string :tip_zast_navol
      t.string :tip_zast_podod
      t.string :tip_krepl
      t.string :tip_stejki
      t.string :okantovka
      t.string :upak
      t.string :tip_upak
      t.string :kol_upak
      t.string :material
      t.string :plotnost
      t.string :barcode
      t.string :vendor
      t.string :cvet
      t.string :tkan_verh
      t.string :tkan_niz
      t.string :sostav

      t.timestamps null: false
    end
  end
end
