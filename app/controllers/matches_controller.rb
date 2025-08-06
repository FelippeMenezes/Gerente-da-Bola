class MatchesController < ApplicationController
  before_action :set_match, only: %i[show edit update destroy]

  def index
    @matches = Match.all
  end

  def show; end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    if @match.save
      redirect_to @match, notice: 'Match created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @match.update(match_params)
      redirect_to @match, notice: 'Match updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @match.destroy
    redirect_to matches_path, notice: 'Match deleted.'
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:home_team_id, :away_team_id, :home_score, :away_score, :played_at)
  end
end
