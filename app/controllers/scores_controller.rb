class ScoresController < ApplicationController
  def show
    term = params[:term]
    score = ScoreCache.for_term(term)
    value = score.has_score? ? score.value : nil
    render :json =>  { :term => term, :score => value }.to_json
  end
end
