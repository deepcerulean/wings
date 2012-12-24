module Wings
  class Model

    #attr_accessor :identifier

    def initialize
      self.class.instances << self
    end

    def self.all
      puts "-- all called on #{self}"
      self.instances
    end


    def self.instances
      @@instances ||= Array.new
    end

    def self.inherited(subclass)
      #puts "New subclass of model: #{subclass}"
      Wings.active_game.models << self
    end



    #def self.first
    #  self.all.first
    #end

    # may have unintended consequences... but the idea is to get things like #first and #count for free
    # TODO specify delegates -- even the somewhat mind-numbing solution above is better than trying to fix obscure bugs from the below
    def self.method_missing(method_name, *args, &blk)
      if self.all.respond_to?(method_name)
        self.all.send(method_name, *args, &blk)
      else
        super
      end
    end
  end
end