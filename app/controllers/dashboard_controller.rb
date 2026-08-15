class DashboardController < ApplicationController
  def index
    salary = Configuration.where(user: current_user).last.try(:salary).to_f
    user_payment = Payment.where(user: current_user).order(:payday).last
    total_paid = user_payment.try(:value).to_f
    balance = salary - total_paid

    @last_user_payment = user_payment
    @salary = salary
    @total_paid = total_paid
    @balance = balance

    #chart 1: paid vs remaining balance this month
    @balance_chart = { labels: ["Pago", "Saldo"], data: [total_paid, balance] }

    #chart 2: expenses paid this month, by category
    expenses_by_category = {}
    if user_payment.present?
      expenses_by_category = user_payment.expense_payments.joins(:category).group('categories.name').sum(:value)
    end
    @expenses_by_category_chart = { labels: expenses_by_category.keys, data: expenses_by_category.values.map(&:to_f) }

    #chart 3: total paid per month, last 6 months
    monthly_totals = Payment.where(user: current_user)
      .where('payday >= ?', Date.today - 6.months)
      .order(payday: :asc)
      .group(:payday)
      .sum(:value)
    @monthly_paid_chart = {
      labels: monthly_totals.keys.map { |payday| payday.to_fs(:custom_datetime_month_and_year) },
      data: monthly_totals.values.map(&:to_f),
    }
  end
end
