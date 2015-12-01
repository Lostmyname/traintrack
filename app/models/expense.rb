class Expense < ActiveRecord::Base
  belongs_to :person

  validates :name, presence: true
  validates :cost, presence: true
  validates :status, inclusion: { in: %w(pending approved bought rejected) }

  def pretty_date
    date.to_datetime.strftime "%d/%m/%y"
  end
end
