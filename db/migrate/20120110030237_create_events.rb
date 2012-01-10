class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :game_id
      t.date    :date
      t.text    :site
      t.text    :notes
      t.timestamps
    end
  end
end
