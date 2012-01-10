class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :user_id, :null => false
      t.integer :game_id, :null => false
      t.boolean :game_admin, :default => false

      t.timestamps
    end

    add_index(:members, [:user_id, :game_id], :unique => true)
  end
end
