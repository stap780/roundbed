class AddColumnsToMarcs < ActiveRecord::Migration[5.2]
  def change
    add_column :marcs, :razmer, :string
    add_column :marcs, :cvet, :string
  end
end
