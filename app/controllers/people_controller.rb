class PeopleController < ApplicationController

  include ApplicationHelper

  before_action :authenticate_person!
  before_action :authenticate_admin!, only: [:new, :create, :update]

  # List people.
  def index
    @people = Person.all
  end

  # View person.
  def show
    @person = get_person_from_params
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

  # Change a person (budget / admin status), admin only
  def update
    @person = get_person_from_params

    if params[:toggle_admin]
      @person.admin = !@person.admin
    end

    if params[:person][:budget]
      @person.budget = params[:person][:budget]
    end

    @person.save

    redirect_to @person
  end

  private

  def person_params
    params.require(:people).permit(:name, :budget, :admin)
  end

  def get_person_from_params
    Person.find(params[:id] == 'me' ? current_person.id : params[:id])
  end
end
