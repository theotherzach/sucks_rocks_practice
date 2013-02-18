require 'spec_helper'

describe ScoresController do
  before do
    @score = RockScore::Score.new("microsoft", 8.5)
    @no_score = RockScore::NoScore.new("microsoft")
  end
  it "returns a cached score" do
    CachedScore.stub(:for_term).with("microsoft") { @score }
    get :show, :term => "microsoft"
    response.body.should == { :term => "microsoft", :score => 8.5 }.to_json
  end

  it "returns null for no_scores" do
    CachedScore.stub(:for_term).with("microsoft") { @no_score }
    get :show, :term => "microsoft"
    response.body.should == { :term => "microsoft", :score => nil }.to_json
  end
end
