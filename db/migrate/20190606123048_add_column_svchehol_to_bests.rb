class AddColumnSvcheholToBests < ActiveRecord::Migration[5.2]
  def change
    add_column :bests, :sv_chehol, :string
  end
end
