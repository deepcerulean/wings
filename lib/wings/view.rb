module Wings
  class View

    def render

      # call draw on subclass
      draw!

    end

    def self.inherited(subclass)
      puts "New subclass of view: #{subclass}"
      Game.current.views << self
    end
  end
end