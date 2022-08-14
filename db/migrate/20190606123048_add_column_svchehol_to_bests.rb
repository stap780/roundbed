class AddColumnSvcheholToBests < ActiveRecord::Migration
  def change
    add_column :bests, :sv_chehol, :string
  end
end
