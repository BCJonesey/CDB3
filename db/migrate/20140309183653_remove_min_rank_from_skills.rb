class RemoveMinRankFromSkills < ActiveRecord::Migration
  def change
  	remove_column :skills, :min_rank, :integer
  end
end
