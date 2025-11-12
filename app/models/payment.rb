class Payment < ApplicationRecord
  belongs_to :user
  has_many :expense_payments, dependent: :destroy
  has_many :revenue_payments, dependent: :destroy
  has_many :expenses, through: :expense_payments
  has_many :revenues, through: :revenue_payments

  validates_presence_of :payday, :status, :user

  accepts_nested_attributes_for :expense_payments, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :revenue_payments, reject_if: :all_blank, allow_destroy: true

  attribute :status, :integer, default: Proc.new { Payment.statuses["aberto"] }

  after_save :total_value

  enum status: {
    aberto: 0,
    concluido: 1
  }

  def expenses_fixed_not_used
    Expense.where(user: user).where(fixed: true).where.not(id: [expense_ids])
  end

  def balance_in_percentage
    salary = ::Configuration.where(user: user).last.try(:salary).to_f
    balance = ((self.value.to_f * 100)/salary).round(2)
  end

  private

  def total_value
    self.value = total_expense_payments - total_revenue_payments
    self.update_column(:value, self.value)
  end

  def total_expense_payments
    self.expense_payments.inject(0){|sum, ep| sum + ep.value }
  end

  def total_revenue_payments
    self.revenue_payments.inject(0){|sum, ep| sum + ep.value }
  end
end
