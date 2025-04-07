class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :customer, foreign_key: true
      t.references :table, foreign_key: true
      t.references :time_slot, foreign_key: true
      t.date :reserved_date
      t.integer :guest_count
      t.text :special_request

      t.timestamps
    end
  end
end
