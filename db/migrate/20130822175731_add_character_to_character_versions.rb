class AddCharacterToCharacterVersions < ActiveRecord::Migration
  def change
    add_column :character_versions, :character_id, :integer
  end
end
