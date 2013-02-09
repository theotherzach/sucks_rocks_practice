class CachedScore < ActiveRecord::Base
  attr_accessible :term, :score
  class NoScore < RuntimeError; end

  def self.for_term(term)
    cached_score = find_by_term(term) or raise NoScore
    result = cached_score.score
    result || RockScore::NoScore
  end

  def self.save_score(term, score)
    score = nil if score == RockScore::NoScore
    create!(:term => term, :score => score)
  end
end
