class CreateDepts < ActiveRecord::Migration[5.2]
  def change
    create_table :depts do |t|
      t.decimal :amount, default: 0.0
      t.date :expire
      t.decimal :interest
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
