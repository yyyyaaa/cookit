class OmniauthCallbacksController < ApplicationController
  skip_before_filter :authenticate_user!, raise: false

  def all
    p env["omniauth.auth"]
    user = User.from_omniauth(env["omniauth.auth"], current_user)
    if user.persisted?
      flash[:notice] = "You are in..!!! Go to edit profile to see the status for the accounts"
      sign_in_and_redirect(user)
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  def failure
    #handle you logic here..
    redirect_to new_user_registration_url, notice: "Sorry, We are having troubles logging you in."
  end

  alias_method :facebook, :all
  alias_method :google_oauth2, :all
  alias_method :passthru, :all

end
