class AddConfirmationDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :confirmation_digest, :string
  end
end
