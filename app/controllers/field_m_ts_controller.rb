class FieldMTsController < ApplicationController
  # GET /field_m_ts
  # GET /field_m_ts.xml
  def index
    @field_m_ts = FieldMTs.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @field_m_ts }
    end
  end

  # GET /field_m_ts/1
  # GET /field_m_ts/1.xml
  def show
    @field_m_ts = FieldMTs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @field_m_ts }
    end
  end

  # GET /field_m_ts/new
  # GET /field_m_ts/new.xml
  def new
    @field_m_ts = FieldMTs.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @field_m_ts }
    end
  end

  # GET /field_m_ts/1/edit
  def edit
    @field_m_ts = FieldMTs.find(params[:id])
  end

  # POST /field_m_ts
  # POST /field_m_ts.xml
  def create
    @field_m_ts = FieldMTs.new(params[:field_m_ts])

    respond_to do |format|
      if @field_m_ts.save
        flash[:notice] = 'FieldMTs was successfully created.'
        format.html { redirect_to(@field_m_ts) }
        format.xml  { render :xml => @field_m_ts, :status => :created, :location => @field_m_ts }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @field_m_ts.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /field_m_ts/1
  # PUT /field_m_ts/1.xml
  def update
    @field_m_ts = FieldMTs.find(params[:id])

    respond_to do |format|
      if @field_m_ts.update_attributes(params[:field_m_ts])
        flash[:notice] = 'FieldMTs was successfully updated.'
        format.html { redirect_to(@field_m_ts) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @field_m_ts.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /field_m_ts/1
  # DELETE /field_m_ts/1.xml
  def destroy
    @field_m_ts = FieldMTs.find(params[:id])
    @field_m_ts.destroy

    respond_to do |format|
      format.html { redirect_to(field_m_ts_url) }
      format.xml  { head :ok }
    end
  end
end
