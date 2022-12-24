class Expense < ApplicationRecord
    
  belongs_to :category
  belongs_to :user
  has_many :expense_payments
  has_many :payments, through: :expense_payments, :dependent => :restrict_with_error
  
  validates_presence_of :name, :category_id, :user

end
