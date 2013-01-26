require_relative '../../app/services/rock_score'
require_relative '../../app/services/search_engine'

describe RockScore do

  it "returns a 0 on unpopular terms" do
    SearchEngine.stub(:count_results).with("apple sucks") { 1 }
    SearchEngine.stub(:count_results).with("apple rocks") { 0 }
    RockScore.for_term("apple").should == 0
  end

  it "returns a 10.0 on popular terms" do
    SearchEngine.stub(:count_results).with("apple sucks") { 0 }
    SearchEngine.stub(:count_results).with("apple rocks") { 1 }
    RockScore.for_term("apple").should == 10.0
  end

  it "returns a mediocre score on mediocre terms" do
    SearchEngine.stub(:count_results).with("apple sucks") { 11 }
    SearchEngine.stub(:count_results).with("apple rocks") { 9 }
    RockScore.for_term("apple").should == 4.5
  end

  it "does not divide by 0" do
    SearchEngine.stub(:count_results).with("apple sucks") { 0 }
    SearchEngine.stub(:count_results).with("apple rocks") { 0 }
    RockScore.for_term("apple").should == RockScore::NoScore
  end
end
