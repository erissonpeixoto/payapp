class DashboardController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def index
    
    salary = ::Configuration.where(user: current_user).last.try(:salary).to_f
    total_value_last_payment = Payment.where(user: current_user).order(:payday).last.try(:value).to_f
    balance = salary - total_value_last_payment
    
    #chart 1
    @chart_pay_and_balance = {"Pago #{number_to_currency(total_value_last_payment, unit: "R$ ", separator: ",", delimiter: ".")}" => total_value_last_payment, "Saldo #{number_to_currency(balance, unit: "R$ ", separator: ",", delimiter: ".")}" => balance}
    @color_chart_pay_and_balance = (balance < 0) ? ["#2E86C1","red"] : ["#2E86C1","#3FBB31"]

    #chart 2
    user_payment = Payment.where(user: current_user).order(:payday).last
    @payment_of_expenses_by_category = []
    if user_payment.present?
      @payment_of_expenses_by_category = user_payment.expense_payments.joins(:category).group('categories.name').sum(:value).map {|category, value| {category => value.to_f}}.inject(:merge!)
    end

    #chart 3
    #last 6 months
    @total_value_by_payment = Payment.where(user: current_user).where('payday >= ?', Date.today - 6.months).order(payday: :asc).group(:payday).sum(:value).map {|payday, value| [payday.to_s(:custom_datetime_month_and_year), value.to_d]}.to_h

  end
end
