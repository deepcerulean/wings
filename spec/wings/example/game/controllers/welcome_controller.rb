
#
#  game controllers are 'states'
#  methods are 'screens' (but can also be 'actions' or 'events'...?)
#  there may be one 'screen' method...
#
class WelcomeController < Wings::GameController
  def splash
    puts "--- splash screenin'"
    @spaceship = Spaceship.new

    # render model?
    # implicit call to render..?
  end
end

####