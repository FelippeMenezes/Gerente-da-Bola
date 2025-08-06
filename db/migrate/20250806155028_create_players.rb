class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.integer :level
      t.integer :yellow_card
      t.integer :red_card
      t.integer :price
      t.boolean :injury
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
