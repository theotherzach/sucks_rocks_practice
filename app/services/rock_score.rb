class RockScore
  class Score < Struct.new(:term, :value)
    def has_score?
      true
    end
  end
  class NoScore < Struct.new(:term)
    def has_score?
      false
    end
  end

  def self.for_term(term)
    value = fetch_value(term)
    value.nan? ? NoScore.new(term) : Score.new(term, value)
  end

  private
  def self.fetch_value(term)
    positive = SearchEngine.count_results(%{"#{term} rocks"}).to_f
    negative = SearchEngine.count_results(%{"#{term} sucks"}).to_f
    10 * positive / (positive + negative)
  end
end
