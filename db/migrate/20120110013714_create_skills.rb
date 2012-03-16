class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.integer :game_id
      t.string :name
      t.string :summary
      t.text :description
      t.integer :min_rank,:default => 0
      t.integer :max_rank,:default => 1

      t.timestamps
    end
  end
end
