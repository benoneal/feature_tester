require 'spec_helper'
require 'feature_tester'

describe FeatureTester do
  let(:user1) { "user1" }
  let(:user2) { "user2" }

  let(:tests) do
    [
      :test1,
      :test2,
      :test3
    ]
  end

  let(:expected_enrolments_for_user1) do
    {
      :test1 => true,
      :test2 => false,
      :test3 => true,
    }
  end

  let(:expected_enrolments_for_user2) do
    {
      :test1 => true,
      :test2 => true,
      :test3 => false,
    }
  end

  it "produces deterministic test enrolments" do
    result1 = FeatureTester.new(user1, tests).enrolments
    result2 = FeatureTester.new(user2, tests).enrolments

    expect(result1).to eq expected_enrolments_for_user1
    expect(result2).to eq expected_enrolments_for_user2
  end

  it "returns enrolment in specified tests" do
    result1 = FeatureTester.new(user1, tests).enroled?(:test2)
    result2 = FeatureTester.new(user2, tests).enroled?(:test2)

    expect(result1).to eq expected_enrolments_for_user1[:test2]
    expect(result2).to eq expected_enrolments_for_user2[:test2]
  end
end
