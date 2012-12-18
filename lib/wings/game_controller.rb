module Wings
  class GameController
    attr_accessor :actions
    attr_accessor :views

    def initialize
      puts "--- game controller created"
    end

    def process(action, *args)
      action_name = action.to_s

      unless action_name = method_for_action(action_name)
        raise "The action '#{action_name}' could not be found for #{self.class.name}."
      end

      process_action(action_name, *args)
    end

    def process_action(action_name, *args)
      # prep?

      # invoke action
      #action_name.call(*args)
      old_instance_variables = instance_variables
      send action_name, *args
      new_instance_variables = instance_variables
      instance_variables_delta = new_instance_variables

      puts "--- created several instance variables!"

      view_name = action_name.to_s

      # implicit render (i.e., unless we were told otherwise)
      unless view = view_for_action(view_name)
        raise "The view '#{view_name}' could not be found for #{self.class.name}"
      end

      # this is incredibly messsy!

      render_view(view_name) unless render_interrupted?

    end

    def render_view(view_name, opts={})
      view_for_action(view_name)
      render(opts)
    end

    def view_frozen
      @view_frozen ||= false
    end

    def view_obviated
      @view_obviated ||= false
    end

    def render_interrupted?
      view_frozen || view_obviated
    end

    def view_for_action(action_name)
      views.select do |view|
        view.class.name == action_name
      end
    end

    def method_for_action(action_name)
      actions.select { |action| action.name == action_name }
    end


    def self.inherited(subclass)
      puts "New subclass of game_controller: #{subclass}"
      Game.current.controllers << self
    end
  end
end