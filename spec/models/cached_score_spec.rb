require 'spec_helper'

describe CachedScore do
  before do
    @score = RockScore::Score.new("microsoft", 7.5)
    @no_score = RockScore::NoScore.new("microsoft")
  end

  it "remembers scores" do
    CachedScore.save_score(@score)
    CachedScore.for_term("microsoft").value.should == 7.5
  end

  it "raises an exception if the term isn't cached" do
    expect do
      CachedScore.for_term("microsoft")
    end.to raise_error(CachedScore::NoScore)
  end

  it "saves no scores as nil" do
    CachedScore.save_score(@no_score)
    CachedScore.for_term("microsoft").has_score?.should == false
  end
end
