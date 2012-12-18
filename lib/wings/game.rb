module Wings
  class Game
    attr_accessor :controllers
    attr_accessor :models
    attr_accessor :views

    attr_accessor :state
    attr_accessor :environment

    def initialize(opts={})
      @environment = opts.delete(:environment) { 'development' }


      if @@initial_state
        puts "--- i am a game with an initial state!"
        activate @@initial_state
      end
    end

    def start!(opts={})
      puts '--- would be launching game!'
      puts "--- would be connecting to view engine, etc."
      puts "--- got options: "
      p opts
      puts "=== running in environment: #{@environment}"

    end


    def activate(state)
      @state = state
    end

    def method_missing(method_sym, *arguments, &block)
      # attempt to route to current state...
      if @state.respond_to?(method_sym)
      else
        super
      end
    end

    #def self.inherited(subclass)
    #  puts "--- subclassed game!"
    #  @@current = subclass
    #end

    def self.initial_state(initial_state)
      @@initial_state = initial_state
    end

    def self.start(init_opts={}, game_opts={})
      @@current = self.new(init_opts)
      @@current.start!(game_opts)
    end
  end
end