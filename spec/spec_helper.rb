$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'feature_tester'

module FeatureTesterHelpers
  def tests
    [
      :test1,
      :test2,
      :test3,
      :test4
    ]
  end

  def test id
    FeatureTester.new(id, tests)
  end
end

RSpec.configure do |c|
  c.include FeatureTesterHelpers
end
