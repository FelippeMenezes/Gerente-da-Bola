class Team < ApplicationRecord
  belongs_to :user, optional: true
  
  has_many :players, dependent: :destroy
  has_many :home_matches, class_name: 'Match', foreign_key: 'home_team_id', dependent: :destroy
  has_many :away_matches, class_name: 'Match', foreign_key: 'away_team_id', dependent: :destroy

  validates :name, presence: true

  def incomplete?
    players.count < 11
  end
end
