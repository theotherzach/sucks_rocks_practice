class RockScore
  NoScore = Class.new

  def self.for_term(term)
    positive = SearchEngine.count_results("#{term} rocks").to_f
    negative = SearchEngine.count_results("#{term} sucks").to_f
    result = 10 * positive / (positive + negative)
    result.nan? ? NoScore : result
  end
end
