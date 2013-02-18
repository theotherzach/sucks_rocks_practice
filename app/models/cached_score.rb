class CachedScore < ActiveRecord::Base
  attr_accessible :term, :score
  class NoScore < RuntimeError; end

  def self.for_term(term)
    cached_score = find_by_term(term) or raise NoScore
    result = cached_score.score
    if result 
      RockScore::Score.new(term, result)
    else
      RockScore::NoScore.new(term)
    end
  end

  def self.save_score(score)
    value = score.has_score? ? score.value : nil
    create!(:term => score.term, :score => value)
  end
end
