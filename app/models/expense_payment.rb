class ExpensePayment < ApplicationRecord

  validates_presence_of :value

  belongs_to :expense
  belongs_to :payment

  has_one :category, through: :expense

  validates_uniqueness_of :expense_id, :scope => :payment_id, if: Proc.new { expense.fixed? }, :message => "Despesas fixas só podem ser adicionadas apenas uma vez"

end
