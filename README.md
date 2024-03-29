# Wings

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/deepcerulean/wings)

An MVC-based game programming framework for Ruby. (Awesome, right?)

# Thoughts

Some notes on the thought here.

Wings is going to eventually live on a server and push update-deltas out to clients. Something like minotaur could be running on top, 'housing'
the game a bit further (once appropriate connections are available there.)

'Icarus' might be the name of the plugin for rack/rails that instruments the rails server with the technology to launch
a wings server, communicate with clients, and maybe even launch a JS/HTML5-based browser client.

For the time being, like with minotaur, the server aspect is going to be elided in favor of getting interesting behavior
in the client. We'll treat the decoupling as a secondary refactor later in the process. (This might be painful and necessitate
a rewrite; however, this wings should still be valuable. At the moment, let's indicate 1.0 as the wings in which full client-server
services should be supported, and with backwards-compatible support for direct library clients.)

## Installation

Add this line to your application's Gemfile:

    gem 'wings'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wings

That said, it doesn't do too much yet.

## Usage

Soon, the idea is to be able to create a game using this framework directly. That's somewhat far-off, but you can
take a look at the `examples` directory to get an idea for what might be possible.

## Contributing

Got an idea for the project? Great!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


# History

0.0.1 -- initial release, containing:
    * sketch of example project structure
    * basic MVC infrastructure (along with simple test demonstrating routing)