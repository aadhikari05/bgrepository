class RedirectUrlsController < ApplicationController
  # GET /redirect_urls
  # GET /redirect_urls.xml
  def index
    @redirect_urls = RedirectUrl.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @redirect_urls }
    end
  end

  # GET /redirect_urls/1
  # GET /redirect_urls/1.xml
  def show
    @redirect_url = RedirectUrl.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @redirect_url }
    end
  end

  # GET /redirect_urls/new
  # GET /redirect_urls/new.xml
  def new
    @redirect_url = RedirectUrl.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @redirect_url }
    end
  end

  # GET /redirect_urls/1/edit
  def edit
    @redirect_url = RedirectUrl.find(params[:id])
  end

  # POST /redirect_urls
  # POST /redirect_urls.xml
  def create
    @redirect_url = RedirectUrl.new(params[:redirect_url])

    respond_to do |format|
      if @redirect_url.save
        flash[:notice] = 'RedirectUrl was successfully created.'
        format.html { redirect_to(@redirect_url) }
        format.xml  { render :xml => @redirect_url, :status => :created, :location => @redirect_url }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @redirect_url.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /redirect_urls/1
  # PUT /redirect_urls/1.xml
  def update
    @redirect_url = RedirectUrl.find(params[:id])

    respond_to do |format|
      if @redirect_url.update_attributes(params[:redirect_url])
        flash[:notice] = 'RedirectUrl was successfully updated.'
        format.html { redirect_to(@redirect_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @redirect_url.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /redirect_urls/1
  # DELETE /redirect_urls/1.xml
  def destroy
    @redirect_url = RedirectUrl.find(params[:id])
    @redirect_url.destroy

    respond_to do |format|
      format.html { redirect_to(redirect_urls_url) }
      format.xml  { head :ok }
    end
  end
end
