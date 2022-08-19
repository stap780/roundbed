class CreatePermcls < ActiveRecord::Migration[5.2]
  def change
    create_table :permcls do |t|
      t.string :systitle
      t.string :title

      t.timestamps null: false
    end
  end
end
