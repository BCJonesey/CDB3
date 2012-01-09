class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name, :null => false
      t.integer :member_id, :null => false
      t.timestamps
    end
  end
end
