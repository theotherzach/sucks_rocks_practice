require 'spec_helper'

describe ScoresController do
  it "returns a cached score" do
    CachedScore.stub(:for_term).with("microsoft") { 8.5 }
    get :show, :term => "microsoft"
    response.body.should == { :term => "microsoft", :score => 8.5 }.to_json
  end

  it "returns null for no_scores" do
    CachedScore.stub(:for_term).with("microsoft") { RockScore::NoScore }
    get :show, :term => "microsoft"
    response.body.should == { :term => "microsoft", :score => nil }.to_json
  end
end
