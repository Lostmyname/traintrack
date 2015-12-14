class Person < ActiveRecord::Base
  devise :omniauthable, :rememberable, :omniauth_providers => [:slack]
  has_many :expenses

  validates :name, presence: true, uniqueness: true
end
