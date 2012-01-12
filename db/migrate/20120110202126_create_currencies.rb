class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :short_name
      t.integer :yearly_cap
      t.integer :game_id

      t.timestamps
    end
  end
end
