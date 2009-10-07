class SearchesController < ApplicationController

  #before_filter :find_search

  SEARCHES_PER_PAGE = 20
  
  def create
    # if we have the name, we can save it to the database with the criteria.
    # if not, we can just display the search results (show action)
    params[:search][:field_ministry_ids] ||= []
    logger.debug "params[:search] = #{params[:search].to_yaml}"
    @search = Search.new(params[:search])
    search_criteria = @search.criteria
    logger.debug "search is: #{@search.to_yaml}"
    session[:search_criteria] = @search.criteria
    session[:field_ministry_involvement_ids] = params[:search][:field_ministry_ids]
    logger.debug "set session to: #{session[:search_criteria].to_yaml}"    
    #redirect_to "/searches/results"
    
    # determine the correct search URL to redirect to, and store it in the session so we can link to it with the top tabs.
    search_url = "/searches/results"
    if @search.name?
      logger.debug "@search has a name of #{@search.name}"
      if @search.save
        flash[:notice] = 'Search was successfully saved.'
        search_url = search_path(@search)
      else
        logger.debug "Error(s) saving search: #{@search.errors.to_yaml}"          
        flash[:warning] = "Error saving search: #{@search.errors.full_messages}"
      end
    else
      # if name not supplied, but criteria is the same as the search it is based on, just redirect to that search
      based_on = Search.find(@search.based_on)
      logger.debug("Search Criteria = #{@search.criteria.to_yaml}")
      logger.debug("Based On Search Criteria = #{based_on.criteria.to_yaml}")
      search_url = "/searches/results"
      if based_on.criteria == @search.criteria and based_on.field_ministry_ids == @search.field_ministry_ids
        search_url = search_path(based_on)
      end
    end
    session[:last_search_path] = search_url
    redirect_to search_url
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
    logger.debug "existing_search.attributes = #{existing_search.attributes.to_yaml}"
    @search = Search.new(existing_search.criteria)
    if params[:based_on]
      @search.based_on = params[:based_on].to_i
    end
    @search.field_ministry_ids = existing_search.field_ministries.collect(&:id)
    logger.debug "@search = #{@search.to_yaml}"
    logger.debug "@search.field_ministries = #{@search.field_ministries.to_yaml}"
    respond_to do |format|
      format.html
      format.xml  { render :xml => @search }
    end
  end

  def show
    #render :text => session[:search_criteria].to_yaml
    begin
      @search = Search.find_by_name(params[:id])
      if !@search
        @search = Search.new(session[:search_criteria])
        @ministry_involvement_ids = session[:field_ministry_involvement_ids]
      else
        @ministry_involvement_ids = @search.search_involvements.collect { |s| s.field_ministry_id }
      end
    end
    logger.debug "@search = #{@search.to_yaml}"
    #logger.debug "Retrieved session paramaters of: #{@search_criteria.to_yaml}"
    conditions = @search.sql_conditions
    logger.debug "Conditions before adding field_ministry_id constraint = #{conditions.to_yaml}"
    field_ministry_id_in_condition = "(field_ministry_id IN (?))"
    if conditions.empty?
      conditions.push field_ministry_id_in_condition
    else
      conditions[0] += " AND " + field_ministry_id_in_condition
    end
    conditions.push @ministry_involvement_ids
    involvements = FieldMinistryInvolvement.all :conditions => conditions, :joins => {:client => :person}
    @results = involvements.collect { |si| si.client }
    #@results = Client.all :conditions => @search.sql_conditions, :joins => :person
    respond_to do |format|
      format.html
    end
  end
  private

  def find_search
    @search = Search.find(params[:id]) if params[:id]
  end

end