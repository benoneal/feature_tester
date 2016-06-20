require 'digest'

class FeatureTester
  attr_reader :id, :experiments

  def initialize(id, experiments = [])
    raise "You must provide an ID" if id.empty?
    @id = id.dup.freeze
    @experiments = experiments.dup.freeze
  end

  def enroled?(experiment)
    enrolments[experiment]
  end

  def enrolments
    Hash[*self.experiments.zip(assignments).flatten]
  end

  private

  def assignments
    binary_from_seed(self.id).split('').map { |b| b == '1' }
  end

  def binary_from_seed(seed)
    Digest::SHA256.digest(seed).unpack("C*").map { |n| n.to_s(2) }.join
  end

end
