class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.integer :character_id
      t.integer :approved_by_id
      t.integer :created_by_id
      t.text :comment
      t.decimal :amount
      t.integer :currency_id

      t.timestamps
    end
  end
end
