class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :game_id
      t.datetime :start_date
      t.datetime :end_date
      t.text    :site
      t.text    :notes
      t.integer :player_cap
      t.timestamps
    end
  end
end
