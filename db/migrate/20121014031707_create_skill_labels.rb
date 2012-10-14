class CreateSkillLabels < ActiveRecord::Migration
  def change
    create_table :skill_labels do |t|
      t.boolean :gives, :default => false
      t.integer :skill_id
      t.integer :label_id

      t.timestamps
    end
  end
end
