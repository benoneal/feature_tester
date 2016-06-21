require 'spec_helper'
require 'feature_tester'

describe FeatureTester do
  let(:user1) { "user1" }
  let(:user2) { "user2" }

  let(:expected_enrolments_for_user1) do
    {
      :test1 => false,
      :test2 => false,
      :test3 => false,
      :test4 => false,
    }
  end

  let(:expected_enrolments_for_user2) do
    {
      :test1 => false,
      :test2 => true,
      :test3 => true,
      :test4 => false,
    }
  end

  it "produces deterministic test enrolments" do
    result1 = test(user1).enrolments
    result2 = test(user2).enrolments

    expect(result1).to eq expected_enrolments_for_user1
    expect(result2).to eq expected_enrolments_for_user2
  end

  it "returns enrolment in specified tests" do
    result1 = test(user1).enroled?(:test2)
    result2 = test(user2).enroled?(:test2)

    expect(result1).to eq expected_enrolments_for_user1[:test2]
    expect(result2).to eq expected_enrolments_for_user2[:test2]
  end

  it "raises on empty id" do
    expect { test("") }.to raise_error("You must provide an ID")
  end

  it "works as intended" do
    expect(test("7d4c81c64ad8b55de7a698793d85b2b2").enroled?(:test1)).to eq true
    expect(test("eeaf224ffcd596f33d0267b32845d2ef").enroled?(:test1)).to eq false
    expect(test("27806e10f033309dfed398660f4b8d73").enroled?(:test1)).to eq true
    expect(test("eeedbfab242852f88f11bc98b8ae7e3f").enroled?(:test1)).to eq true
    expect(test("85bad3e10ac1b925ff215d99684b062f").enroled?(:test1)).to eq true
    expect(test("0baac2242db1d19af2203bb8010fa9cc").enroled?(:test1)).to eq true

    expect(test("7d4c81c64ad8b55de7a698793d85b2b2").enroled?(:test2)).to eq false
    expect(test("eeaf224ffcd596f33d0267b32845d2ef").enroled?(:test2)).to eq true
    expect(test("27806e10f033309dfed398660f4b8d73").enroled?(:test2)).to eq false
    expect(test("eeedbfab242852f88f11bc98b8ae7e3f").enroled?(:test2)).to eq false
    expect(test("85bad3e10ac1b925ff215d99684b062f").enroled?(:test2)).to eq false
    expect(test("0baac2242db1d19af2203bb8010fa9cc").enroled?(:test2)).to eq false

    expect(test("7d4c81c64ad8b55de7a698793d85b2b2").enroled?(:test3)).to eq true
    expect(test("eeaf224ffcd596f33d0267b32845d2ef").enroled?(:test3)).to eq true
    expect(test("27806e10f033309dfed398660f4b8d73").enroled?(:test3)).to eq false
    expect(test("eeedbfab242852f88f11bc98b8ae7e3f").enroled?(:test3)).to eq false
    expect(test("85bad3e10ac1b925ff215d99684b062f").enroled?(:test3)).to eq false
    expect(test("0baac2242db1d19af2203bb8010fa9cc").enroled?(:test3)).to eq false

    expect(test("7d4c81c64ad8b55de7a698793d85b2b2").enroled?(:test4)).to eq true
    expect(test("eeaf224ffcd596f33d0267b32845d2ef").enroled?(:test4)).to eq true
    expect(test("27806e10f033309dfed398660f4b8d73").enroled?(:test4)).to eq false
    expect(test("eeedbfab242852f88f11bc98b8ae7e3f").enroled?(:test4)).to eq false
    expect(test("85bad3e10ac1b925ff215d99684b062f").enroled?(:test4)).to eq true
    expect(test("0baac2242db1d19af2203bb8010fa9cc").enroled?(:test4)).to eq true
  end
end
