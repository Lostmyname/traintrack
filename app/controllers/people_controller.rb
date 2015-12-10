class PeopleController < ApplicationController

  before_action :authenticate_person!, only: [:new, :create]

  # List people.
  def index
    @people = Person.all
  end

  # View person.
  def show
    # number or "me"
    @person = Person.find(params[:id])
    @expense = Expense.new
  end

  # Form to create a person. Admin only.
  def new
    @person = Person.new
  end

  # Create a person. Admin only.
  def create
    @person = Person.new(person_params)
    @person.update_attributes(remaining: @person.budget)

    if @person.save
      redirect_to @person
    else
      render 'new'
    end
  end

  private

  def person_params
    params.require(:people).permit(:name, :budget, :admin)
  end
end
