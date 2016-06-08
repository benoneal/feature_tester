# FeatureTester

Very simple gem to reliably assign users to control or test groups for the purpose of testing new features (A/B testing). No database required: it simply derives test enrolment from your user's unique identifier. 

All users have a 50/50 chance to be enroled in any test. If you need more granularity than that then this is not the gem for you.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'feature_tester'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install feature_tester

## Usage

Super simple: instantiate FeatureTester with your user identification (guid, id, uuid, or any persistent string really), and an array of the test conditions you want the user assigned to: 

    :user_id = "12345"
    :test_conditions = [:test_condition1, :test_condition2]
    test = FeatureTester.new(:user_id, :test_conditions)

    test.enrolments #=> {:test_condition1 => true, :test_condition2 => false}
    test.enroled?(:test_condition1) #=> true
    test.enroled?(:test_condition1) #=> false

If you want test enrolment to be persistent, only append to your test_conditions array, never replace or delete (you can trivially deprecate old tests by renaming them though, such as "test_condition1_deprecated", or even "*_succeeded" or "*_failed" if you want to maintain a manual record of your test results).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

