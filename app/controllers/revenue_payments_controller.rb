class RevenuePaymentsController < ApplicationController
  before_action :set_revenue_payment

  # PATCH /payments/1/revenue_payments/2
  #
  # Toggles paid_at on/off. Lives inside a turbo_frame_tag on the payment's
  # show page, so the row re-renders in place without leaving the page or
  # opening the full edit form.
  def update
    @revenue_payment.update!(paid_at: @revenue_payment.paid_at.present? ? nil : Date.current)
    render partial: "revenue_payments/row", locals: { revenue_payment: @revenue_payment }
  end

  private

  def set_revenue_payment
    payment = Payment.where(user: current_user).find(params[:payment_id])
    @revenue_payment = payment.revenue_payments.find(params[:id])
  end
end
