class CreateInterests < ActiveRecord::Migration[5.2]
  def change
    create_table :interests do |t|
      t.string :range
      t.decimal :rate

      t.timestamps
    end
  end
end
