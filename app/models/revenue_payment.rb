class RevenuePayment < ApplicationRecord
  validates_presence_of :value

  belongs_to :revenue
  belongs_to :payment

  has_one :category, through: :revenue

  validates_uniqueness_of :revenue_id, :scope => :payment_id, if: Proc.new { revenue.fixed? }, :message => "Receitas fixas só podem ser adicionadas apenas uma vez"

end
