class CreatePermclActions < ActiveRecord::Migration[5.2]
  def change
    create_table :permcl_actions do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
