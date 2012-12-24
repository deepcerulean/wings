
#
#  an example top-level game object with project-level config
#
class ExampleGame < Wings::Game
  #
  #  set initial game controller (and other global events if need be...)
  #
  on launch: 'welcome#splash', as: 'home'
end

# setup project root
ExampleGame.root = File.expand_path("../..", __FILE__)