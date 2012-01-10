class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.integer :game_id
      t.string :name
      t.string :summary
      t.text :description

      t.timestamps
    end
  end
end
