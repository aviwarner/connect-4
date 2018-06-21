require_relative 'controllers/game_state'

system "clear"

game = GameState.new

puts "Welcome to Connect 4!\nThis is a 2 player local game, you'll use the 1-7 keys to play.\n\nPress ENTER to start!"
selection = gets.to_i
game.new_game
