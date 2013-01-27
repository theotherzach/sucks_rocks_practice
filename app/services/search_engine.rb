class SearchEngine

  def self.count_results(query)
    google = Google::Search::Web.new(:query => query)
    google.response.estimated_count
  end
end
