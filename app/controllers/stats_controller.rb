class StatsController < ApplicationController
  before_action :authenticate_person!

  def index
    @number_per_month = Expense.group("date_trunc('month', created_at)").count
    @cost_per_month = Expense.group("date_trunc('month', created_at)").sum(:cost)
  end
end
