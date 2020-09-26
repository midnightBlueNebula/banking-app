class CreateSavingsAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :savings_accounts do |t|
      t.decimal :balance
      t.decimal :interest
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
