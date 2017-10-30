class AddWeightToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :weight, :integer
  end
end