When /^I search for (.*)$/ do |term|
  @scores ||= {}
  visit query_path(:term => term)
  score = ActiveSupport::JSON.decode(page.source).fetch("score")
  @scores[term] = score
end

Then /^the beatles should have a higher score than comcast$/ do
  @scores["the beatles"].should be > @scores["comcast"]
end
