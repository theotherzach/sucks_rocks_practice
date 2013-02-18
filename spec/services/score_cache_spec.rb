require_relative "../../app/services/rock_score"
require_relative "../../app/services/score_cache"

class CachedScore
  class NoScore < RuntimeError; end
end

describe ScoreCache do
  before do
    @score = RockScore::Score.new("microsoft", 5.5) 
  end

  it "returns a cached score if it exists" do
    CachedScore.stub(:for_term).with("microsoft") { @score }
    ScoreCache.for_term("microsoft").value.should == 5.5
  end

  context "when the term is not cached" do
    before do
      RockScore.stub(:for_term).with("microsoft") { @score }
      CachedScore.stub(:for_term).with("microsoft").
        and_raise(CachedScore::NoScore)
      CachedScore.stub(:save_score)
    end

    it "recomputes score" do
      ScoreCache.for_term("microsoft").value.should == 5.5
    end

    it "stores new scores in the database" do
      CachedScore.should_receive(:save_score).with(@score)
      ScoreCache.for_term("microsoft").value.should == 5.5
    end
  end
end
