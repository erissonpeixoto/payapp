class AddValueToExpensePayments < ActiveRecord::Migration[5.2]
  def change
    add_column :expense_payments, :value, :decimal, precision: 8, scale: 2
  end
end
