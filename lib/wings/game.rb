module Wings
  class Game

    attr_accessor :controllers, :models, :views
    attr_accessor :environment

    def initialize(opts={})
      @environment = opts.delete(:environment) { 'development' }
    end

    def launch!(opts={})
      #puts "=== running in environment: #{@environment}"

      load_resources!
      handle(:launch)
    end

    def current_controller
      @@current_controller ||= nil
    end

    def activate(controller, action, *args)
      #puts "--- activating controller #{controller} action #{action}"
      @@current_controller = controller.new
      #puts "--- assigned current controller! #{@@current_controller}"
      @@current_controller.process(action, *args)
    end


    def load_resources!
      #puts "=== load resources"
      require("#{self.class.root}/config/env/#{@environment}")
      Find.find("#{self.class.root}/game") do |path|
        next if FileTest.directory?(path)
        require(path) if File.basename(path).include?('.rb')
      end
    end


    def controllers
      @controllers ||= []
    end

    def models
      @models ||= []
    end

    def views
      @views ||= []
    end

    def handle(event)
      if self.class.routes.has_key?(event)
        activate(*dereference_controller_and_action(self.class.routes[event]))
      end
    end


    def method_missing(method_sym, *arguments, &block)
      puts "--- called game#method_missing with #{method_sym}"

      puts "--- does current controller '#{@@current_controller}' respond?"
      if @@current_controller.respond_to?(method_sym)
        puts "--- yes!"
        @@current_controller.send(method_sym, *arguments, &block)
      else
        puts "--- no... :("
        super
      end
    end



    def self.current
      @@current ||= nil
    end

    class <<self
      attr_accessor :routes, :named_routes
      attr_accessor :root

      def play!(init_opts={}, game_opts={})
        Wings.play(self, init_opts, game_opts)
      end

      def routes
        @@routes ||= {}
      end

      def named_routes
        @@named_routes ||= []
      end

      def on(events_and_routes, opts={})
        events_and_routes.each do |evt,route|
          routes[evt] = route
          named_routes[route] = opts[:as] if opts[:as]
        end
      end
    end

    private

    def dereference_controller_and_action(string)
      controller_name, action_name = string.split('#')
      controller_name = "#{controller_name}_controller".camelize
      #puts "--- attempting to constantize #{controller_name}"
      controller = controller_name.constantize
      [controller, action_name.to_sym]
    end
  end
end