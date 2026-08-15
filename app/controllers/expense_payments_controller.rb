class ExpensePaymentsController < ApplicationController
  before_action :set_expense_payment

  # PATCH /payments/1/expense_payments/2
  #
  # Toggles paid_at on/off. Lives inside a turbo_frame_tag on the payment's
  # show page, so the row re-renders in place without leaving the page or
  # opening the full edit form.
  def update
    @expense_payment.update!(paid_at: @expense_payment.paid_at.present? ? nil : Date.current)
    render partial: "expense_payments/row", locals: { expense_payment: @expense_payment }
  end

  private

  def set_expense_payment
    payment = Payment.where(user: current_user).find(params[:payment_id])
    @expense_payment = payment.expense_payments.find(params[:id])
  end
end
