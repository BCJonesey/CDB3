class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :event_id
      t.integer :member_id
      t.integer :character_id, :default=>nil
      t.boolean :is_paid, :default=>false
      t.boolean :is_present, :default=>false
      t.boolean :is_prereged, :default=>false
      t.boolean :setup_cleanup, :default=>false
      t.integer :cp_game_id, :default=>nil

      t.timestamps
    end
  end
end
