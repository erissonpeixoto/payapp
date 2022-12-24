class Category < ApplicationRecord

  belongs_to :user
  has_many :expenses, :dependent => :restrict_with_error
  
  validates_presence_of :name, :user
end
