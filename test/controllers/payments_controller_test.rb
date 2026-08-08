require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @payment = payments(:one)
    @revenue = Revenue.create!(name: 'Salário', category: categories(:one), user: users(:one))
  end

  test "should get index" do
    get payments_url
    assert_response :success
  end

  test "should get new" do
    get new_payment_url
    assert_response :success
  end

  test "should create payment" do
    assert_difference('Payment.count') do
      post payments_url, params: { payment: { payday: '01/08/2026', status: 'aberto' } }
    end

    assert_redirected_to payment_url(Payment.last)
  end

  test "should save paid dates for expense and revenue payments" do
    assert_difference('Payment.count') do
      post payments_url, params: {
        payment: {
          payday: '01/08/2026',
          status: 'aberto',
          expense_payments_attributes: {
            '0' => { expense_id: expenses(:one).id, value: '100.00', paid_at: '02/08/2026' }
          },
          revenue_payments_attributes: {
            '0' => { revenue_id: @revenue.id, value: '250.00', paid_at: '03/08/2026' }
          }
        }
      }
    end

    payment = Payment.last
    assert_equal Date.new(2026, 8, 1), payment.payday.to_date
    assert_equal Date.new(2026, 8, 2), payment.expense_payments.first.paid_at.to_date
    assert_equal Date.new(2026, 8, 3), payment.revenue_payments.first.paid_at.to_date
  end

  test "should filter payments by status, category and period" do
    get payments_url, params: {
      status_filter: 'aberto',
      category_id: categories(:two).id,
      period_start: '01/08/2026',
      period_end: '01/08/2026'
    }

    assert_response :success
    assert_select 'tbody tr', count: 1
  end

  test "should show payment" do
    get payment_url(@payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_payment_url(@payment)
    assert_response :success
  end

  test "should update payment" do
    patch payment_url(@payment), params: { payment: { payday: '01/08/2026', status: 'aberto' } }
    assert_redirected_to payment_url(@payment)
  end

  test "should destroy payment" do
    assert_difference('Payment.count', -1) do
      delete payment_url(@payment)
    end

    assert_redirected_to payments_url
  end
end
