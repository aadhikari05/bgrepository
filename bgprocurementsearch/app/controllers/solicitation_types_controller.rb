class SolicitationTypesController < ApplicationController
  # GET /solicitation_types
  # GET /solicitation_types.xml
  def index
    @solicitation_types = SolicitationType.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @solicitation_types }
    end
  end

  # GET /solicitation_types/1
  # GET /solicitation_types/1.xml
  def show
    @solicitation_type = SolicitationType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @solicitation_type }
    end
  end

  # GET /solicitation_types/new
  # GET /solicitation_types/new.xml
  def new
    @solicitation_type = SolicitationType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @solicitation_type }
    end
  end

  # GET /solicitation_types/1/edit
  def edit
    @solicitation_type = SolicitationType.find(params[:id])
  end

  # POST /solicitation_types
  # POST /solicitation_types.xml
  def create
    @solicitation_type = SolicitationType.new(params[:solicitation_type])

    respond_to do |format|
      if @solicitation_type.save
        flash[:notice] = 'SolicitationType was successfully created.'
        format.html { redirect_to(@solicitation_type) }
        format.xml  { render :xml => @solicitation_type, :status => :created, :location => @solicitation_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @solicitation_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /solicitation_types/1
  # PUT /solicitation_types/1.xml
  def update
    @solicitation_type = SolicitationType.find(params[:id])

    respond_to do |format|
      if @solicitation_type.update_attributes(params[:solicitation_type])
        flash[:notice] = 'SolicitationType was successfully updated.'
        format.html { redirect_to(@solicitation_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @solicitation_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /solicitation_types/1
  # DELETE /solicitation_types/1.xml
  def destroy
    @solicitation_type = SolicitationType.find(params[:id])
    @solicitation_type.destroy

    respond_to do |format|
      format.html { redirect_to(solicitation_types_url) }
      format.xml  { head :ok }
    end
  end
end
