class AddBlockToCheckingAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :checking_accounts, :blocked, :boolean, default: false
  end
end
