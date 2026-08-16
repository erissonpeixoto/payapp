module PaymentsHelper
  # Net result of the month: positive when revenue covered expenses, negative
  # otherwise -- the inverse of Payment#value, which stores net *outflow*
  # (expense - revenue) for the salary vs. spending math on the dashboard.
  def payment_net(payment)
    payment.revenue_payments.sum(&:value) - payment.expense_payments.sum(&:value)
  end

  # Salary-relative balance: what's left of the configured salary after this
  # month's revenue and expenses -- salário + (receitas - despesas).
  def salary_balance(payment)
    payment_salary(payment) + payment_net(payment)
  end

  # nil when there's no salary configured -- a percentage of zero is meaningless.
  def salary_balance_percentage(payment)
    salary = payment_salary(payment)
    return nil if salary.zero?

    salary_balance(payment) / salary * 100
  end

  def payment_salary(payment)
    Configuration.where(user: payment.user).last.try(:salary).to_f
  end

  def ledger_month_label(payday)
    I18n.l(payday, format: "%B %Y")
  end

  def ledger_period_label(payday)
    start_date = payday.beginning_of_month
    end_date = payday.end_of_month
    "#{start_date.day.to_s.rjust(2, '0')}–#{end_date.day.to_s.rjust(2, '0')} de #{I18n.l(start_date, format: '%B').downcase}"
  end

  def paid_chip_label(paid_at, kind)
    return kind == :expense ? "Marcar como pago" : "Marcar como recebido" if paid_at.blank?

    verb = kind == :expense ? "Pago em" : "Recebido em"
    "#{verb} #{paid_at.strftime('%d/%m/%Y')}"
  end

  def paid_chip_classes(paid_at)
    base = "inline-flex items-center gap-1 whitespace-nowrap rounded-full px-3 py-1.5 text-xs font-semibold"
    if paid_at.present?
      "#{base} bg-revenue-tint/15 text-revenue"
    else
      "#{base} border border-dashed border-line-strong text-ink-soft hover:bg-paper-sunken"
    end
  end

  def destroy_payment_confirm(payment)
    "Excluir o fechamento de #{ledger_month_label(payment.payday)}? " \
      "Isso remove #{pluralize(payment.expense_payments.size, 'despesa')} e " \
      "#{pluralize(payment.revenue_payments.size, 'receita')} vinculadas."
  end
end
