class ExpensesController < ApplicationController

  include ActionView::Helpers::NumberHelper

  before_action :authenticate_person!
  before_action :authenticate_admin!, only: [:index, :show, :update]

  def new
    @expense = Expense.new
  end

  def create
    @expense = current_person.expenses.create(expense_params)
    @expense.status = 'pending'

    if @expense.save
      redirect_to current_person

      message = "#{current_person.name} would like to go to #{@expense.name}, which is on #{@expense.pretty_date} and costs #{format_currency @expense.cost}: #{expense_url(@expense)}"
      NotificationsService.send_channel_message(ENV['SLACK_CHANNEL'], message)
    else
      render 'new'
    end
  end

  # List all, filter by pending. Admin only.
  def index
    @expenses_pending = Expense.where(status: 'pending')
    @expenses_approved = Expense.where(status: 'approved')
  end

  # See details, change status. Admin only.
  def show
    @expense = Expense.find(params[:id])
  end

  # Change expense status. Admin only.
  def update
    @expense = Expense.find(params[:id])
    @expense.update_attributes(status: params[:status])

    message = case params[:status]
      when 'rejected'
        "Your request to attend #{@expense.name} has been rejected by #{current_person.name} for reason: #{params[:reason]}."
      when 'approved'
        @expense.person.recalculate_remaining!
        @expense.person.save

        "Your request to attend #{@expense.name} has been approved by #{current_person.name}."
      when 'bought'
        "Your ticket for #{@expense.name} has been bought by #{current_person.name}—expect an email soon!"
      else
        "The status for your request to attend #{@expense.name} has been changed to #{params[:status]} by #{current_person.name}"
      end

    NotificationsService.send_user_message(@expense.person.uid, message)

    redirect_to @expense
  end

  private

  def expense_params
    params.require(:expenses).permit(:name, :date, :cost, :url, :notes)
  end
end
