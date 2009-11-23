class ParsedFilesController < ApplicationController
  # GET /parsed_files
  # GET /parsed_files.xml
  def index
    @parsed_files = ParsedFile.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @parsed_files }
    end
  end

  # GET /parsed_files/1
  # GET /parsed_files/1.xml
  def show
    @parsed_file = ParsedFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @parsed_file }
    end
  end

  # GET /parsed_files/new
  # GET /parsed_files/new.xml
  def new
    @parsed_file = ParsedFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @parsed_file }
    end
  end

  # GET /parsed_files/1/edit
  def edit
    @parsed_file = ParsedFile.find(params[:id])
  end

  # POST /parsed_files
  # POST /parsed_files.xml
  def create
    @parsed_file = ParsedFile.new(params[:parsed_file])

    respond_to do |format|
      if @parsed_file.save
        flash[:notice] = 'ParsedFile was successfully created.'
        format.html { redirect_to(@parsed_file) }
        format.xml  { render :xml => @parsed_file, :status => :created, :location => @parsed_file }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @parsed_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /parsed_files/1
  # PUT /parsed_files/1.xml
  def update
    @parsed_file = ParsedFile.find(params[:id])

    respond_to do |format|
      if @parsed_file.update_attributes(params[:parsed_file])
        flash[:notice] = 'ParsedFile was successfully updated.'
        format.html { redirect_to(@parsed_file) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @parsed_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /parsed_files/1
  # DELETE /parsed_files/1.xml
  def destroy
    @parsed_file = ParsedFile.find(params[:id])
    @parsed_file.destroy

    respond_to do |format|
      format.html { redirect_to(parsed_files_url) }
      format.xml  { head :ok }
    end
  end
end
