module ApplicationHelper
  def format_currency(amount)
    args = { unit: '£' }

    if amount % 1 == 0
      args[:precision] = 0;
    end

    number_to_currency(amount, args)
  end
end
