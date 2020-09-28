class AddBlockToSavingsAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :savings_accounts, :blocked, :boolean, default: false
  end
end
