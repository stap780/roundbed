class AddColumnsToLaetes < ActiveRecord::Migration
  def change
    add_column :laetes, :cprice, :decimal
    add_column :laetes, :oprice, :decimal
    add_column :laetes, :sdesc, :string
    add_column :laetes, :desc, :string
  end
end
