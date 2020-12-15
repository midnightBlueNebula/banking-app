class AddCurrencyToSavingsAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :savings_accounts, :currency, :string
  end
end
