class AddColumnsToMarcs < ActiveRecord::Migration
  def change
    add_column :marcs, :razmer, :string
    add_column :marcs, :cvet, :string
  end
end
