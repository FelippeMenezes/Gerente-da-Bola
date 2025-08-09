class MarketController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_verify_user_team

  def index
    @players_for_sale = Player.where(for_sale: true)
  end

  private

  def set_and_verify_user_team
    @team = current_user.teams.first

    redirect_to new_team_path, alert: "Você precisa criar um time para acessar o mercado!" if @team.nil?
  end
end
