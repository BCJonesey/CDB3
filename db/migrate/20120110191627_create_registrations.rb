class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :event_id
      t.integer :member_id
      t.integer :character_id
      t.boolean :paid
      t.boolean :present
      t.boolean :setup_cleanup
      t.integer :cp_game_id

      t.timestamps
    end
  end
end
