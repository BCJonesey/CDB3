class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string  :name, :null => false
      t.boolean :public, :default => true
      t.timestamps
    end
  end
end
