class Person < ActiveRecord::Base
  has_many :expenses

  validates :name, presence: true
  validates :budget, presence: true
  validates :remaining, presence: true
end
