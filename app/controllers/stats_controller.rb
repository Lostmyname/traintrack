class StatsController < ApplicationController
  before_action :authenticate_person!

  def index
    trunc = "date_trunc('month', date)"
    @number_per_month = Expense.group(trunc).order(trunc).count
    @cost_per_month = Expense.group(trunc).order(trunc).sum(:cost)
  end
end
