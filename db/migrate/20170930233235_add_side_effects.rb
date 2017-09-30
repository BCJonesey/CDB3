class AddSideEffects < ActiveRecord::Migration
  def change
    add_column :games, :side_effects, :text
    add_column :skills, :side_effects, :text
  end
end
