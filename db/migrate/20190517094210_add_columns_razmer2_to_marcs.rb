class AddColumnsRazmer2ToMarcs < ActiveRecord::Migration[5.2]
  def change
    add_column :marcs, :razmer2, :string
    add_column :marcs, :sostav, :string
  end
end
