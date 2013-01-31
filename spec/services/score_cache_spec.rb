require_relative "../../app/services/rock_score"
require_relative "../../app/services/score_cache"

class CachedScore
  class NoScore < RuntimeError; end
end

describe ScoreCache do
  it "returns a cached score if it exists" do
    CachedScore.stub(:for_term).with("microsoft") { 5.5 }
    ScoreCache.for_term("microsoft").should == 5.5
  end

  context "when the term is not cached" do
    before do
      RockScore.stub(:for_term).with("microsoft") { 5.5 }
      CachedScore.stub(:for_term).with("microsoft").
        and_raise(CachedScore::NoScore)
      CachedScore.stub(:save_score)
    end

    it "recomputes score" do
      ScoreCache.for_term("microsoft").should == 5.5
    end

    it "stores new scores in the database" do
      CachedScore.should_receive(:save_score).with("microsoft", 5.5)
      ScoreCache.for_term("microsoft").should == 5.5
    end
  end
end
