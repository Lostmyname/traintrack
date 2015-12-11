class ExpensesController < ApplicationController

  include ApplicationHelper

  before_action :authenticate_person!
  before_action :authenticate_admin!, only: [:index, :show, :update]

  # List all, filter by pending. admin only.
  def index
    @expenses_pending = Expense.where(status: 'pending')
    @expenses_approved = Expense.where(status: 'approved')
  end

  # Admin only. See details, change status.
  def show
    @expense = Expense.find(params[:id])
  end

  # Admin only. Change ticket status.
  def update
    @expense = Expense.find(params[:id])
    @expense.update_attributes(status: params[:status])
    @expense.save

    if params[:status] == 'approved'
      @expense.person.decrement(:remaining, @expense.cost)
      @expense.person.save
    end

    redirect_to @expense
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = current_person.expenses.create(expense_params)
    @expense.update_attributes(status: 'pending')

    @expense.save

    redirect_to current_person
  end

  private

  def expense_params
    params.require(:expenses).permit(:name, :date, :cost, :url, :notes)
  end
end
