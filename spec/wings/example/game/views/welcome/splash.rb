class Splash < Wings::View
  #
  #  controller variables automatically passed to view...
  #
  def draw
    puts "--- attempting to render splash view"
    @spaceship.draw
  end
end
