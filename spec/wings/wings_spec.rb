require 'rspec'
require 'wings'


####




describe Wings do
  before(:each) do
    ExampleGame.start(environment: 'drydock')
  end

  it "is an awesome framework" do
    #fail 'insufficient awesomeness quotient'

    ExampleModel.any_instance.should_receive :click
    ExampleGame.click(at: [4,5])
  end
end