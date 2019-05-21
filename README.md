# PipelineDeals chart 

## Demo
[pipelinedeals-chart.herokuapp.com](https://pipelinedeals-chart.herokuapp.com)

## System Dependencies
- Ruby 2.6.3 (install with [rbenv](https://github.com/sstephenson/rbenv))
- Rubygems
- Bundler (`gem install bundler`)
- Foreman (`gem install foreman`)

## Installation and usage
```
bundle install
```
```
foreman start -f Procfile.dev -p 3000
```

## Tests
```
bundle exec rspec spec/
```

### Implementation details
Application displays single page containing a column chart. Data is from PipelineDeals API.

As future improvements I suggest to implement caching mechanism for external API (e.g. by using Redis) and/or rate limiting for internal API.

#### What I did
- PipelineDeals API wrapper
- service object for calculating totals
- Controller action rendering JSON
- unit tests
- basic interface with React
- proposed improvements
- deployed to Heroku