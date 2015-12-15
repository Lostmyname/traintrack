class Person < ActiveRecord::Base
  devise :omniauthable, :rememberable, :omniauth_providers => [:slack]
  has_many :expenses

  validates :name, presence: true, uniqueness: true

  default_scope {
    order('name ASC')
  }

  def recalculate_remaining!
    total = expenses.inject(0) { |sum, expense| sum + expense.cost }
    self.remaining = budget - total
  end
end
