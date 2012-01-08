class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :global_admin, :default => false

      t.timestamps
    end
  end
end
