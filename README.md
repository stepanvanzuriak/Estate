# Estate

Simple predictable state manager inspaired by [reworm](https://github.com/pedronauck/reworm)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  estate:
    github: stepanvanzuriak/estate
```

## Usage

### Get state

```crystal
require "estate"

state = Estate.create({name: "Steve", age: 19})

puts state.get({"name"}) # "Steve"
puts state.get({"name", "age"}) # {"Steve", 19}

```

### Change state

```crystal
require "estate"

state = Estate.create({bugs: 12, features: 13})

state.set { |prev| {features: prev["features"] + 1, bugs: prev["bugs"] + 10} }
puts state.get # {bugs: 22, features: 14}
```

### Don't repeat yourself with select

```crystal
require "estate"

state = Estate.create({name: "Jhon", status: "king", age: 21})

status = state.select({"status"})

puts status.call # "king"
puts status.call # "king"

extra_age = state.select { | state | state["age"] + 2 }

puts extra_age.call # 23
puts extra_age.call # 23

state.set { |prev| {age: prev["age"] + 1} }

puts extra_age.call # 24
```

## Contributing

1. Fork it (<https://github.com/your-github-user/estate/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [stepanvanzuriak](https://github.com/stepanvanzuriak) your-name-here - creator, maintainer
