class Spaceship < Wings::Model

  attr_accessor :position

  def position
    @position ||= [0,0]
  end

  def click
    puts 'good click!'
    # move_to(position)...
  end
end
