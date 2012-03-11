class CreateCharacterSkills < ActiveRecord::Migration
  def change
    create_table :character_skills do |t|
      t.integer :character_version_id
      t.integer :skill_id
      t.integer :rank

      t.timestamps
    end
  end
end
