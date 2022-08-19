class AddColumnsUrlToMarcs < ActiveRecord::Migration[5.2]
  def change
    add_column :marcs, :url, :string
  end
end
