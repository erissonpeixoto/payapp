class CreateRevenuePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :revenue_payments do |t|
      t.references :revenue, foreign_key: true
      t.references :payment, foreign_key: true
      t.decimal :value, precision: 8, scale: 2

      t.timestamps
    end
  end
end
