class FieldMinistriesController < ApplicationController

  before_filter :find_field_ministry

  FIELD_MINISTRIES_PER_PAGE = 20

  def create
    @field_ministry = FieldMinistry.new(params[:field_ministry])
    respond_to do |format|
      if @field_ministry.save
        flash[:notice] = 'FieldMinistry was successfully created.'
        format.html { redirect_to @field_ministry }
        format.xml  { render :xml => @field_ministry, :status => :created, :location => @field_ministry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @field_ministry.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @field_ministry.destroy
        flash[:notice] = 'FieldMinistry was successfully destroyed.'        
        format.html { redirect_to field_ministries_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'FieldMinistry could not be destroyed.'
        format.html { redirect_to @field_ministry }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @field_ministries = FieldMinistry.paginate(:page => params[:page], :per_page => FIELD_MINISTRIES_PER_PAGE)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @field_ministries }
    end
  end

  def edit
  end

  def new
    @field_ministry = FieldMinistry.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @field_ministry }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @field_ministry }
    end
  end

  def update
    respond_to do |format|
      if @field_ministry.update_attributes(params[:field_ministry])
        flash[:notice] = 'FieldMinistry was successfully updated.'
        format.html { redirect_to @field_ministry }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @field_ministry.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_field_ministry
    @field_ministry = FieldMinistry.find(params[:id]) if params[:id]
  end

end