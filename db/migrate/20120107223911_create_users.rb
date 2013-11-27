class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,         :null => false 
      t.string :email,         :null => false 
      t.boolean :global_admin, :default => false
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil

      t.timestamps
    end

    add_index :users, [:email], :unique => true
  end
end

