class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :user_id
      t.integer :game_id
      t.boolean :game_admin, :default => false

      t.timestamps
    end
  end
end
