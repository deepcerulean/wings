module Wings
  class Model
    def initialize

    end

    def self.inherited(subclass)
      puts "New subclass of model: #{subclass}"
      Game.current.models << self
    end
  end
end