require_dependency "haystack/application_controller"

class Haystack::SearchesController < ApplicationController
  def new
    @data = []
    @searcher = "#{params[:type]}Searcher".constantize.new
  end

  def create
    @searcher = "#{params[:type]}Searcher".constantize.new
    @data = @searcher.data

    respond_to do |format|
      format.html { render 'new' }
      format.js   { render 'new' }
      format.json { render :json => @data }
    end
  
  end
end