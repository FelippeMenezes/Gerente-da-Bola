# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  before_action :handle_user_redirect, if: :user_signed_in?, unless: :devise_controller?

  private

  def handle_user_redirect
    # Evita redirecionamentos indesejados se já estivermos numa página de equipas
    # ou a processar a sua criação/atualização.
    return if controller_name == "teams"

    # Verifica se o utilizador tem equipas.
    # A consulta `first` é eficiente, pois só precisa de encontrar uma equipa.
    user_team = current_user.teams.first

    if user_team.present?
      # CASO 1: O utilizador JÁ TEM uma equipa.
      # Redireciona para a página de exibição (show) da primeira equipa encontrada.
      redirect_to team_path(user_team)
    else
      # CASO 2: O utilizador NÃO TEM nenhuma equipa.
      # Redireciona para a página de criação de uma nova equipa.
      redirect_to teams_new_path
    end
  end
end

