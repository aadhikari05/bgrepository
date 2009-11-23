class SetasidesController < ApplicationController
  # GET /setasides
  # GET /setasides.xml
  def index
    @setasides = Setaside.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @setasides }
    end
  end

  # GET /setasides/1
  # GET /setasides/1.xml
  def show
    @setaside = Setaside.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @setaside }
    end
  end

  # GET /setasides/new
  # GET /setasides/new.xml
  def new
    @setaside = Setaside.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @setaside }
    end
  end

  # GET /setasides/1/edit
  def edit
    @setaside = Setaside.find(params[:id])
  end

  # POST /setasides
  # POST /setasides.xml
  def create
    @setaside = Setaside.new(params[:setaside])

    respond_to do |format|
      if @setaside.save
        flash[:notice] = 'Setaside was successfully created.'
        format.html { redirect_to(@setaside) }
        format.xml  { render :xml => @setaside, :status => :created, :location => @setaside }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @setaside.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /setasides/1
  # PUT /setasides/1.xml
  def update
    @setaside = Setaside.find(params[:id])

    respond_to do |format|
      if @setaside.update_attributes(params[:setaside])
        flash[:notice] = 'Setaside was successfully updated.'
        format.html { redirect_to(@setaside) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @setaside.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /setasides/1
  # DELETE /setasides/1.xml
  def destroy
    @setaside = Setaside.find(params[:id])
    @setaside.destroy

    respond_to do |format|
      format.html { redirect_to(setasides_url) }
      format.xml  { head :ok }
    end
  end
end
