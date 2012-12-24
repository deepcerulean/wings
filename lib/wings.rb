require "find"

require "wings/ext/string"


require "wings/version"

require "wings/model"
require "wings/game_controller"
require "wings/view"

require "wings/game"

module Wings
  # Your code goes here...
  def self.play(game, init_opts={}, game_opts={})
    puts "--- starting game #{game}"
    @@active_game = game.new(init_opts)
    puts "--- current game: #{@@active_game}"
    @@active_game.launch!(game_opts)
    @@active_game
  end

  def self.active_game
    @@active_game ||= nil
  end
end

def wings
  Wings
end
