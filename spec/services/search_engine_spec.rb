require 'google-search'
require 'vcr'
require_relative '../../app/services/search_engine'
require 'vcr_helper'

describe SearchEngine do
  it "counts results" do
    VCR.use_cassette("windows-vs-beos") do
      beos = SearchEngine.count_results("beos")
      microsoft = SearchEngine.count_results("microsoft")
      microsoft.should be > beos
    end
  end
end
