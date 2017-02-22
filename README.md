# ChronoRb

To experiment with that code, run `bin/console` for an interactive prompt.

then
```
ChronoRb::CLI.start(%w(start))
```

or

```
bin/chrono_rb start
```

## Installation

install it with:

    $ gem install chrono_rb
    $ chrono_rb

For developper:

```bash
gem build chrono_rb.gemspec
gem install chrono_rb-0.1.0.gem
chrono_rb
# display help

# uninstall
gem uninstall chrono_rb
```

## Usage

```
./bin/chrono_rb
```

## Tests

```
rspec
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/chrono_rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
