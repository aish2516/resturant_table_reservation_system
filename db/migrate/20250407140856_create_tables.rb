class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :tables do |t|
      t.integer :table_number
      t.integer :capacity
      t.string :location

      t.timestamps
    end
  end
end
