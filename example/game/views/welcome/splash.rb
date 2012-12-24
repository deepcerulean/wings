class Splash < Wings::View
  #
  #  controller variables automatically passed to view...?
  #
  def draw
    puts "--- attempting to render splash view"
    puts "--- defined @spaceship? #{@spaceship}"
    puts "=== got spaceship: #{@spaceship}"
  end
end
