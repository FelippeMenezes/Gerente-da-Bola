class Player < ApplicationRecord
  belongs_to :team, optional: true

  validates :name, uniqueness: true
  validates :position, presence: true
  validates :level, :yellow_card, :red_card, :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :injury, inclusion: { in: [true, false] }
end
