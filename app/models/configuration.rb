class Configuration < ApplicationRecord

  belongs_to :user

  validates_presence_of :salary, :user
end