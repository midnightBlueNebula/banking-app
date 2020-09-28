class AddNewColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :income, :decimal, default: 0.0
  end
end
