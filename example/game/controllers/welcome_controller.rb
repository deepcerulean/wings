#
#  game controllers are 'states'
#  methods are 'screens' (but can also be 'actions' or 'events'...?)
#  there may be one 'screen' method...
#
class WelcomeController < Wings::GameController

  def splash
    puts "--- splash screenin'!!!!!"
    puts "--- creating spaceship..."
    @spaceship = Spaceship.new
    puts "--- new spaceship: "
    p @spaceship
  end

  def click(position)
    #@spaceship = Spaceship.first

    # handle click somehow!?
    @spaceship.click if position[:at] == @spaceship.position
  end

end