# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  before_action :handle_user_redirect, if: :user_signed_in?, unless: :devise_controller?

  private

  def handle_user_redirect
    # Prevents unwanted redirects if we're already on a team page or processing its creation/update.
    return if controller_name == "teams"

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
      redirect_to teams_new_path
    end
  end
end

