class Revenue < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :revenue_payments
  has_many :payments, through: :revenue_payments, :dependent => :restrict_with_error

  validates_presence_of :name, :category_id, :user

end
