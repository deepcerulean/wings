require 'spec_helper'

describe Wings do
  let(:game)  do
    ExampleGame.play!(environment: 'test')
  end

  before(:each) do
    puts game
  end

  it "is an awesome framework" do
    #Spaceship.all.should_not be_empty
    Spaceship.any_instance.should_receive :click
    game.click(at: Spaceship.first.position)
  end
end