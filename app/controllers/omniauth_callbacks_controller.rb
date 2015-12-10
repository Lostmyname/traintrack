class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def slack

    @person = Person.find_or_create_by(provider: auth_hash[:provider], uid: auth_hash[:uid]) do |person|
      person.name = auth_hash[:info][:name]
    end

    sign_in_and_redirect @person, :event => :authentication
  end

  def auth_hash
    request.env["omniauth.auth"]
  end
end