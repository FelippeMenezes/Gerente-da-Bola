class PlayersController < ApplicationController
    before_action :set_player, only: [:show, :edit, :update, :destroy, :sell, :for_sale, :buy]
    before_action :authorize_owner!, only: [:sell, :for_sale]

  def index
    @players = Player.all
  end

  def show; end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to @player, notice: 'Player created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @player.update(player_params)
      redirect_to @player, notice: 'Player updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @player.destroy
    redirect_to players_path, notice: 'Player deleted.'
  end

  def for_sale
    @player.update(for_sale: true)
    redirect_to team_path(@player.team), notice: "#{@player.name} foi colocado à venda no mercado."
  end

  def remove_from_sale
    @player.update(for_sale: false)
    redirect_to team_path(@player.team), notice: "#{@player.name} foi retirado do mercado."
  end
  
  private

  def set_player
    @player = Player.find(params[:id])
  end

  def authorize_owner!
    redirect_to root_path, alert: "Ação não autorizada." unless @player.team.user == current_user
  end

  def player_params
    params.require(:player).permit(:name, :position, :level, :yellow_card, :red_card, :goal_scored, :price, :injury, :team_id, :price)
  end
end
