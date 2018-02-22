class WelcomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    @colors = [
      'border border-warning',
      'border border-success',
      'border border-secondary',
      'border border-danger',
      'border border-primary'
    ]

    @teams = Team.all
  end
end
