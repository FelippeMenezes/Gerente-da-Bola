class AddBudgetToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :budget, :integer, default: 10000
  end
end
