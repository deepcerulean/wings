module Wings
  class GameController
    attr_accessor :actions
    attr_accessor :views

    def initialize
      puts "--- game controller created"
    end

    # feel like we should just go ahead and make this method missing, right?
    #def click(position)
    #  process(:click, position)
    #end
    #def

    def process(action, *args)
      action_name = action

      #unless action_name = method_for_action(action_name)
      unless actions.include?(action_name)
        raise "The action '#{action_name}' could not be found for #{self.class.name}."
      end

      process_action(action_name, *args)
    end

    def process_action(action_name, *args)
      # prep?
      puts "--- attempting to process action '#{action_name}'"

      # invoke action
      #action_name.call(*args)
      old_instance_variables = instance_variables

      # invoke action
      send action_name, *args

      #return if render_interrupted?

      new_instance_variables = instance_variables
      instance_variables_delta = new_instance_variables - old_instance_variables

      puts "--- created several instance variables!"
      puts instance_variables_delta.join(", ")

      view_name = action_name.to_s

      # implicit render (i.e., unless we were told otherwise)
      #unless view_for_action(view_name)

      puts "--- attempting to render view!"
      puts "--- implicit view name: #{view_name}"

      puts "--- current views: "
      p views
      #
      #p views.map { |v| v.to_s.split('::').last }
      #unless views.map(&:to_s).include?(view_name.camelize)
      #  raise "The view '#{view_name}' could not be found for #{self.class.name}"
      #end

      unless views.include?(view_for_action(view_name))
        raise "The view '#{view_name}' could not be found for #{self.class.name}"
      end

      # seems incredibly messsy!
      view = view_for_action(view_name).new

      #p view

      instance_variables_delta.each do |variable_name|
        #puts "--- inspecting instance variable #{variable_name}"
        #puts "--- has value #{self.instance_variable_get(variable_name.to_sym)}"
        #if self.respond_to?(variable_name)
        #  puts "=== attempting to set #{variable_name} to #{self.instance_variable_get(variable_name)} in view..."
        view.instance_variable_set(variable_name, self.instance_variable_get(variable_name))
        #end
      end

      view.render # unless interrupted...
    end

    # TODO actually track views by controller :/
    def views
      Wings.active_game.views
    end

    def view_for_action(view_name)
      view_name.camelize.constantize
    end

    #def render_view(view_name, opts={})
    #  #view_for_action(view_name)
    #  render(opts)
    #end

    #def view_frozen
    #  @view_frozen ||= false
    #end
    #
    #def view_obviated
    #  @view_obviated ||= false
    #end
    #
    #def render_interrupted?
    #  view_frozen || view_obviated
    #end

    #def view_for_action(action_name)
    #  views.select do |view|
    #    view.class.name == action_name
    #  end
    #end

    #def method_for_action(action_name)
    #  puts "--- attempting to find method for action #{action_name}"
    #  puts "--- current actions: "
    #  p actions
    #
    #  #actions.select do |action|
    #  #  action == action_name
    #  #end
    #  action
    #end

    def actions
      # yessiree, there be lots of cheap hacks round these parts
      self.methods - GameController.instance_methods
    end

    def self.inherited(subclass)
      #puts "New subclass of game_controller: #{subclass}"
      Wings.active_game.controllers << self
    end

    ## method missing/respond to -- always towards the end

    def method_missing(method_sym, *arguments, &block)
      # attempt to route to current state...
      if actions.include?(method_sym) #@@current_controller.respond_to?(method_sym)
                                      #@@current_controller.send(method_sym, *arguments, &block)
        process_action(method_sym, *argument, &block)
      else
        super
      end
    end

    # It's important to know Object defines respond_to to take two parameters: the method to check, and whether to include private methods
    # http://www.ruby-doc.org/core/classes/Object.html#M000333
    def respond_to?(method_sym, include_private = false)
      puts "--- controller#respond_to called with '#{method_sym}'"
      puts "--- current actions: #{actions.join(',')}"

      if actions.include?(method_sym.to_s) # =~ /^find_by_(.*)$/
        true
      else
        super
      end
    end
  end
end