class HomeController < ApplicationController

  before_action :authenticate_person!

  def index
    if current_person_admin?
      redirect_to expenses_path
    else
      redirect_to person_path('me')
    end
  end
end
