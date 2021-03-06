class CreateCharacterVersions < ActiveRecord::Migration
  def change
    create_table :character_versions do |t|
      t.integer :previous_version_id
      t.string :description,:default=>"Current Version"

      t.timestamps
    end
    add_column :characters, :character_version_id, :integer
  end
end
