class AddStartingAmountToCurrency < ActiveRecord::Migration
  def change
    add_column :currencies, :starting_amount, :decimal
  end
end