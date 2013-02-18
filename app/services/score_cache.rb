class ScoreCache
  def self.for_term(term)
    begin
      CachedScore.for_term(term)
    rescue CachedScore::NoScore
      value = RockScore.for_term(term)
      CachedScore.save_score(value)
      value
    end
  end
end
