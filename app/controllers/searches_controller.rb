class SearchesController < ApplicationController

  #before_filter :find_search

  SEARCHES_PER_PAGE = 20
  
  def create
    # if we have the name, we can save it to the database with the criteria.
    # if not, we can just display the search results (show action)
    logger.debug "params[:search] = #{params[:search].to_yaml}"
    @search = Search.new(params[:search])
    search_criteria = params[:search]
    logger.debug "search_criteria is: #{search_criteria.to_yaml}"
    session[:search_criteria] = search_criteria
    logger.debug "set session to: #{session[:search_criteria].to_yaml}"    
    redirect_to "/searches/results"
    #respond_to do |format|
    #  if @search.name?
    #    if @search.save
    #      flash[:notice] = 'Search was successfully saved.'
    #    end
    #  end
    #  format.html { render :action => :show }
    #end
  end

  def new
    begin
      if (params[:based_on])
        existing_search = Search.find(params[:based_on].to_i)
      else
        raise
      end
    rescue
      # either could not find specified record (invalid id or whatever), or none was supplied
      # so use the default search
      existing_search = Search.find_by_name "Everybody"
    end
    @search = Search.new(existing_search.criteria)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @search }
    end
  end

  def show
    #render :text => session[:search_criteria].to_yaml
    @search = Search.new(session[:search_criteria])
    #logger.debug "Retrieved session paramaters of: #{@search_criteria.to_yaml}"
    @results = Client.all :conditions => @search.sql_conditions, :joins => :person
    respond_to do |format|
      format.html
      format.xml  { render :xml => @search }
    end
  end
  private

  def find_search
    @search = Search.find(params[:id]) if params[:id]
  end

end