class CreatePermcls < ActiveRecord::Migration
  def change
    create_table :permcls do |t|
      t.string :systitle
      t.string :title

      t.timestamps null: false
    end
  end
end
