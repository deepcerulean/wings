require 'rspec'
require 'wings'

#puts "--- attempting to require example game config"
$:.unshift File.dirname(__FILE__)
#p $:

@in_spec_directory = false
begin
  unless @in_spec_directory
    require './example/config/game'
  else
    require '../example/config/game'
  end
rescue Exception
  unless @in_spec_directory
    @in_spec_directory = true
    retry
  end
end
