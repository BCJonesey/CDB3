class ChangeYearlyCapToCap < ActiveRecord::Migration
  def change
    rename_column :currencies, :yearly_cap, :cap
  end
end
