module ApplicationHelper
  def format_currency(amount)
    args = { unit: '£' }

    if amount % 1 == 0
      args[:precision] = 0;
    end

    formatted = number_to_currency(amount, args)

    if amount < 0
      return "<span style='color: red'>#{formatted}</span>".html_safe
    end

    formatted
  end

  def current_person_admin?
    person_signed_in? && current_person.admin
  end

  def authenticate_admin!
    unless current_person_admin?
      redirect_to expenses_path
    end
  end

  # Easier to override than change where the default method redirects to
  def authenticate_person!
    unless person_signed_in?
      redirect_to person_omniauth_authorize_path(:slack)
    end
  end
end
