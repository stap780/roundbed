class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.integer :permcl_id
      t.integer :permcl_action_id

      t.timestamps null: false
    end
  end
end
