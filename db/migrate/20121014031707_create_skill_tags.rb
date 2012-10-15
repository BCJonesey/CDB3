class CreateSkillTags < ActiveRecord::Migration
  def change
    create_table :skill_tags do |t|
      t.boolean :gives, :default => false
      t.integer :skill_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
