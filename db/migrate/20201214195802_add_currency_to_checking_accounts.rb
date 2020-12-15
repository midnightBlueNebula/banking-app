class AddCurrencyToCheckingAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :checking_accounts, :currency, :string
  end
end
