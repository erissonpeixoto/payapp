class AddPaidAtToExpenseAndRevenuePayments < ActiveRecord::Migration[5.2]
  def change
    add_column :expense_payments, :paid_at, :datetime
    add_column :revenue_payments, :paid_at, :datetime
  end
end
