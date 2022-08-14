class CreatePermclActions < ActiveRecord::Migration
  def change
    create_table :permcl_actions do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
