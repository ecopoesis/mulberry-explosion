# MulberryExplosion

Gem to compute simple statistics.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mulberry_explosion'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mulberry-explosion

## Usage

Create an instance of `DataCapture`. By default it accepts values up to 1000 but this can be overridden by passing a
new limit into `DataCapture`'s constructor:

```ruby
capture = MulberryExplosion::DataCapture.new
```

Capture values:

```ruby
capture.add(3)
```

Generate statistics:
```ruby
stats = capture.build_stats
```

Access statistics:
```ruby
stats.less(3)
stats.greater(3)
stats.between(3, 6)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the 
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, 
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Design

With unbounded input a library like this would requires a sort somewhere. But that's not allowed because the most we 
can spend is O(n) in `build_stats` and sorts can only guarantee a best case of O(nlog(n)).
 
However since the input range is limited to positive numbers (including 0) under 1000 `DataCapture` can "sort" by 
allocating an array of all possible values and incrementing the values in the array as they are added. `build_stats` 
can then iterate over the array once to count values to the left (and compute the values from the right based on the 
total values seen). This approach works will for a limited range of inputs but it will fall apart with if the range is 
big: don't try it `max` of `MAX_INT`.

The `Statistics` class is a thin wrapper around a map (which Ruby stupidly calls a hash) that contains entries for each 
value we've seen and the number of values below and above it. 

This passes all the requirements:
* `add(n)` is O(1) because it only does array access and incrementing two variables
* `build_stats` is O(n) because it loops through the set of possible value only once
* `less(n)` and `greater(n)` are O(1). They do a single hashmap lookup (technically two but the small inner map / tuple
  will get optimized into array iteration by Ruby).
* `between(n, m)` is also O(1) (or O(2) if you're pedantic): it calls `less` and `greater` each once

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ecopoesis/mulberry-explosion.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
