module Wings
  class View
    attr_accessor :controller

    def render
      puts "--- render called on view!!!"
      # call draw on subclass
      draw

    end

    def self.inherited(subclass)
      #puts "New subclass of view: #{subclass}"

      Wings.active_game.views << subclass

    end

    #def method_missing(method_sym, *arguments, &block)
    #  # attempt to route method calls to controller
    #  # TODO really only for new instance vars...
    #  if @controller.respond_to?(method_sym)
    #    @controller.send(method_sym, *arguments, block)
    #  else
    #    super
    #  end
    #end

  end
end