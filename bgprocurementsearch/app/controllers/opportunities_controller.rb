class OpportunitiesController < ApplicationController
  
  def initialize
    @setasides = Setaside.find(:all, :order => "s_type")
    @sol_types = SolicitationType.find(:all, :order => "s_type")
    @sol_types_hash = retrieve_sol_type_hash
    @states = State.find(:all, :order => "name")
  end
  
  # GET /opportunities
  # GET /opportunities.xml
  def index
    @opportunities = Opportunity.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @opportunities }
    end
  end
  
  # GET /solicitation/search
  def search
    @setaside = param_value('setaside')
    @sol_type = param_value('sol_type')
    @pop_state = param_value('pop_state')
    @only_recovery = param_value('only_recovery')
    @only_recovery_flag = @only_recovery=="only_recovery"
    @keywords = param_value('keywords')
    @sort_c = param_value('sort_c')
    @sort_c = param_value('sort_d')
    #@opportunities = Opportunity.search @keywords, :max_matches => 10_000, :page => params[:page], :per_page => 20, :conditions => conditions
    @opportunities = Opportunity.paginate  :page => params[:page], :per_page => 20, :conditions => conditions, :order =>sort_order('created_at')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @opportunities }
    end
  end

  # GET /opportunities/1
  # GET /opportunities/1.xml
  def show
    @opportunity = Opportunity.find(params[:id])
    puts @opportunity.sol_desc
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @opportunity }
    end
  end

  # GET /opportunities/new
  # GET /opportunities/new.xml
  def new
    @opportunity = Opportunity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @opportunity }
    end
  end

  # GET /opportunities/1/edit
  def edit
    @opportunity = Opportunity.find(params[:id])
  end

  # POST /opportunities
  # POST /opportunities.xml
  def create
    @opportunity = Opportunity.new(params[:opportunity])

    respond_to do |format|
      if @opportunity.save
        flash[:notice] = 'Opportunity was successfully created.'
        format.html { redirect_to(@opportunity) }
        format.xml  { render :xml => @opportunity, :status => :created, :location => @opportunity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @opportunity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /opportunities/1
  # PUT /opportunities/1.xml
  def update
    @opportunity = Opportunity.find(params[:id])

    respond_to do |format|
      if @opportunity.update_attributes(params[:opportunity])
        flash[:notice] = 'Opportunity was successfully updated.'
        format.html { redirect_to(@opportunity) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @opportunity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /opportunities/1
  # DELETE /opportunities/1.xml
  def destroy
    @opportunity = Opportunity.find(params[:id])
    @opportunity.destroy

    respond_to do |format|
      format.html { redirect_to(opportunities_url) }
      format.xml  { head :ok }
    end
  end
  
 
  
 


private  

  def param_value (param_name)
    param_value=""
    if(!param_name.nil?)
      if(request.post?)
        if(!params[param_name].nil?)
          session[param_name] = params[param_name]
          param_value = params[param_name].to_s
        else
          session[param_name] = ""
        end
      elsif(request.get?)
        if(!session[param_name].nil?)
          param_value = session[param_name].to_s
        end
      end
   end
  end
  
  def conditions
    condition_string = ""
    private_methods(false).grep(/_conditions$/).map.each do |m|
        condition_part_string = send(m);
        if(!condition_part_string.nil?)
          condition_string << condition_part_string << " AND "
        end
    end
    condition_string[0..-5]
    #condition_string
  end
 
  def setaside_conditions
    " opportunities.setaside LIKE '%#{@setaside}%' " unless @setaside.blank?
  end
  
  def setaside_default_conditions
    " opportunities.setaside != '' AND opportunities.setaside !='N/A' "
  end
 
 
  def keyword_conditions
    " (opportunities.sol_desc LIKE '%#{@keywords}%'  OR opportunities.subject LIKE '%#{@keywords}%') " unless @keywords.blank?
  end 
  
  def pop_state_conditions
    " opportunities.pop_state LIKE '%#{@pop_state}%' "  unless @pop_state.blank?
  end
  
  def sol_type_conditions
    " opportunities.sol_type LIKE '%#{@sol_type}%' " unless @sol_type.blank?
  end
  
  def active_conditions
    " (opportunities.active_ind = true  OR (opportunities.active_ind is null AND opportunities.resp_date >= '#{DateTime.now}')  OR (opportunities.active_ind is null AND opportunities.resp_date is null AND opportunities.sol_date is not null AND  opportunities.sol_date >= '#{15.days.ago}') ) "
  end
  
  
  def recovery_conditions
    " opportunities.recovery_ind = true " unless !@only_recovery_flag
  end

  def retrieve_sol_type_hash
    soltype_hash = {}
    @sol_types.each do |sol_type| 
      soltype_hash[sol_type.s_value] = sol_type.s_type
    end
    soltype_hash
  end
  
  def sort_order(default)
      "#{(params[:sort_c] || default.to_s).gsub(/[\s;'\"]/,'')} #{params[:sort_d] == 'down' ? 'DESC' : 'ASC'}"
  end
 
end
