puts "Cleaning database..."
Player.destroy_all

puts "Creating 50 players for sale..."

positions = ['Goleiro', 'Zagueiro', 'Lateral', 'Meio-campo', 'Atacante']

50.times do
  Player.create!(
    name: Faker::Name.name,
    position: positions.sample,
    level: rand(50..99),
    price: rand(1_000..15_000),
    for_sale: true,
    yellow_card: rand(0..2),
    red_card: rand(0..2),
    injury: false
  )
end

puts "Seed finished!"

puts "#{Player.count} players created."