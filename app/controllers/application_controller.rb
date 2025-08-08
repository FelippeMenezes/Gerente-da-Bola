# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  before_action :handle_user_redirect, if: :user_signed_in?, unless: :devise_controller?

  private

  def handle_user_redirect
    # This redirect logic should only apply when the user visits the root page.
    # This prevents the user from being redirected away from other important pages
    # like the Market, Players, etc., after they have logged in.
    # We only want to guide them from the home page to their team page.
    return unless controller_name == 'pages' && action_name == 'home'

    # Checks if the user has teams. 
    # The `first` query is efficient, as it only needs to find one team.
    user_team = current_user.teams.first

    if user_team.present?
      # CASE 1: The user ALREADY HAS a team.
      # Redirects to the show page of the first team found.
      redirect_to team_path(user_team)
    else
      # CASE 2: The user DOES NOT HAVE any teams.
      # Redirects to the new team creation page.
      redirect_to new_team_path
    end
  end
end
