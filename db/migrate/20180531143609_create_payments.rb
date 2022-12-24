class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.datetime :payday
      t.decimal :value, precision: 8, scale: 2
      t.integer :status
      t.text :note

      t.timestamps
    end
  end
end
