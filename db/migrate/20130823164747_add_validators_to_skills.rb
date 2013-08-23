class AddValidatorsToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :cost, :text
    add_column :skills, :rule, :text
  end
end
