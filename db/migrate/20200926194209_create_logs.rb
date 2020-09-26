class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.string :occasion
      t.string :activity_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
