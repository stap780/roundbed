class AddColumnsUrlToMarcs < ActiveRecord::Migration
  def change
    add_column :marcs, :url, :string
  end
end
