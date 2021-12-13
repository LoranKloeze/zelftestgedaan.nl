# RailsSettings Model
class Setting < RailsSettings::Base
  cache_prefix { 'v1' }

  field :tests_limit_per_request, default: 4
  field :new_tests_interval, default: 5.minutes
end
