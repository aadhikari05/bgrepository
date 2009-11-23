require "rubygems"
require "mysql"
require "db_connect"

class OpportunityDBHandler
  
  include DBConnect
  
  def insertOpportunitiesIntoDB(opportunities)
     # connect to the MySQL server
     dbh = dbconnection
     # get server version string and display it
     #puts "Server version: " + dbh.get_server_info
     @numOfOpportunitiesAdded = 0
     puts "Total Opps = "+ opportunities.length.to_s
     opportunities.each do |opportunity|
       genSql = generateInsertSQL(opportunity)
        #puts genSql
        if(@numOfOpportunitiesAdded%100 == 0)
          dbh.close if dbh
          dbh = dbconnection
          #puts "new Connection"
        end
        dbh.query(genSql)
        @numOfOpportunitiesAdded =  @numOfOpportunitiesAdded + dbh.affected_rows
     end
    puts "Number of rows inserted: #{@numOfOpportunitiesAdded}"
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      # disconnect from server
      dbh.close if dbh
  end
  
  def deleteAllRecoveryRecords
    # connect to the MySQL server
     dbh = dbconnection
     # get server version string and display it
     #puts "Server version: " + dbh.get_server_info
     dbh.query("DELETE from opportunities where recovery_ind=true")
     
    puts "Number of rows deleted #{dbh.affected_rows}"
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      # disconnect from server
      dbh.close if dbh  
  end


  def generateInsertSQL(opportunity)
    if !opportunity.nil?
      @columnNamePartSQL = ""
      @columnValuePartSQL = ""
      
      if !opportunity.sol_type.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"sol_type")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.sol_type)
      end
      if !opportunity.sol_date.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"sol_date")
        @columnValuePartSQL = appendDateColumnValueToSQL(@columnValuePartSQL,formatDateString(opportunity.sol_date,'%Y/%m/%d'),'%Y/%m/%d')
      end
      if !opportunity.agency.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"agency")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.agency)
      end
      if !opportunity.agency_office.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"agency_office")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.agency_office)
      end
      if !opportunity.agency_location.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"agency_location")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.agency_location)
      end
      if !opportunity.agency_zip.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"agency_zip")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.agency_zip)
      end
      if !opportunity.agency_office_address.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"agency_office_address")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.agency_office_address)
      end
      if !opportunity.classcode.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"classcode")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.classcode)
      end
      if !opportunity.naics.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"naics")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.naics)
      end
      if !opportunity.subject.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"subject")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.subject)
      end
      if !opportunity.sol_nbr.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"sol_nbr")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.sol_nbr)
      end
      if !opportunity.resp_date.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"resp_date")
        @columnValuePartSQL = appendDateColumnValueToSQL(@columnValuePartSQL,formatDateString(opportunity.resp_date,"%Y/%m/%d %H:%M:%S"),"%Y/%m/%d %H:%i:%s")
      end
      if !opportunity.archive_date.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"archive_date")
        @columnValuePartSQL = appendDateColumnValueToSQL(@columnValuePartSQL,formatDateString(opportunity.archive_date,'%Y/%m/%d'),'%Y/%m/%d')
      end
      if !opportunity.archive_policy.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"archive_policy")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.archive_policy)
      end
      if !opportunity.sol_desc.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"sol_desc")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.sol_desc)
      end
      if !opportunity.link_url.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"link_url")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.link_url)
      end
      if !opportunity.link_desc.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"link_desc")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.link_desc)
      end
      if !opportunity.contact.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"contact")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.contact)
      end
      if !opportunity.contact_email.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"contact_email")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.contact_email)
      end
      if !opportunity.contact_email_desc.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"contact_email_desc")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.contact_email_desc)
      end
      if !opportunity.setaside.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"setaside")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.setaside)
      end
      if !opportunity.pop_address.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"pop_address")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.pop_address)
      end
      if !opportunity.pop_zip.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"pop_zip")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.pop_zip)
      end
      if !opportunity.pop_country.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"pop_country")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.pop_country)
      end
      if !opportunity.pop_state.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"pop_state")
        @columnValuePartSQL = appendColumnValueToSQL(@columnValuePartSQL,opportunity.pop_state)
      end
      if !opportunity.active_ind.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"active_ind")
        @columnValuePartSQL = appendBooleanColumnValueToSQL(@columnValuePartSQL,opportunity.active_ind)
      end
      if !opportunity.recovery_ind.nil?
        @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"recovery_ind")
        @columnValuePartSQL = appendBooleanColumnValueToSQL(@columnValuePartSQL,opportunity.recovery_ind)
      end
    
      @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"created_at")
      @columnValuePartSQL = appendDateColumnValueToSQL(@columnValuePartSQL,"current_timestamp",nil)
      @columnNamePartSQL = appendColumnNameToSQL(@columnNamePartSQL,"updated_at")
      @columnValuePartSQL = appendDateColumnValueToSQL(@columnValuePartSQL,"current_timestamp",nil)
    
      @columnNamePartSQL = @columnNamePartSQL[0..-2]
      @columnValuePartSQL = @columnValuePartSQL[0..-2]
      
      @insertSQL =  "INSERT INTO opportunities ( "+@columnNamePartSQL+") VALUES ("+@columnValuePartSQL+")"
          
    end
  end
  
  def appendColumnNameToSQL(sql, columnName)
    sql+columnName+","
  end
  
  def appendColumnValueToSQL(sql, columnValue)
    sql+"'"+ Mysql.quote(columnValue)+"',"
  end
  
  def appendBooleanColumnValueToSQL(sql, columnValue)
    if(!columnValue.nil?  && (columnValue.downcase=="true" || columnValue.downcase=="yes"))
      sql+"true,"
    else
      sql+"false,"
    end
  end
  
  def appendDateColumnValueToSQL(sql, columnValue, dateFormat)
    if(!columnValue.nil?  && !dateFormat.nil?)
      sql+"STR_TO_DATE('"+ Mysql.quote(columnValue)+"','"+dateFormat+"'),"
    elsif columnValue=="current_timestamp"
      sql + "current_timestamp,"
    end
  end
  
  def formatDateString(stringValueOfDate, outputFormat)
    parsingWorked = false
    formattedDateStr  = stringValueOfDate
    
    if(!parsingWorked && stringValueOfDate.length==8 )
      begin
        formattedDateStr = DateTime.strptime(stringValueOfDate,'%m%d%Y').strftime(outputFormat)
        parsingWorked = true
      rescue
        #puts "failed %m%d%Y"
      end
    end
    
    if(!parsingWorked && stringValueOfDate.length==6)
      begin
        formattedDateStr = DateTime.strptime(stringValueOfDate,'%m%d%y').strftime(outputFormat)
        parsingWorked = true
      rescue
        #puts "failed %m%d%y"
      end
    end
    
    
    if(!parsingWorked && stringValueOfDate.length==8)
      begin
        formattedDateStr = DateTime.strptime(stringValueOfDate,'%m/%d/%y').strftime(outputFormat)
        parsingWorked = true
      rescue
        #puts "failed %m/%d/%y"
      end
    end
  
    
    
    if(!parsingWorked && stringValueOfDate.length<=8)
      begin
        formattedDateStr = DateTime.strptime(stringValueOfDate,'%m/%e/%y').strftime(outputFormat)
        parsingWorked = true
      rescue
        #puts "failed %m/%e/%y"
      end
    end
    
    if(!parsingWorked && stringValueOfDate.length==8)
      begin
        formattedDateStr = DateTime.strptime(stringValueOfDate,'%m-%d-%y').strftime(outputFormat)
        parsingWorked = true
      rescue
        #puts "failed %m/%d/%y"
      end
    end
  
    
    
    if(!parsingWorked && stringValueOfDate.length<=8)
      begin
        formattedDateStr = DateTime.strptime(stringValueOfDate,'%m-%e-%y').strftime(outputFormat)
        parsingWorked = true
      rescue
        #puts "failed %m/%e/%y"
      end
    end
    
    if(!parsingWorked)
      begin
        formattedDateStr = DateTime.parse(stringValueOfDate).strftime(outputFormat)
        parsingWorked = true
      rescue
      end
    end
    
    formattedDateStr
  end
  
  
   
 end
 
# require "fbo_textfile_parser"
# c = FBOTextfileParser.new("FBOFeed20011228")
# c.parse
# if !c.opportunities.nil?
#  OpportunityDBHandler.new.insertOpportunitiesIntoDB(c.opportunities)
# end


#puts OpportunityDBHandler.new.formatDateString("11/13/2009  4:00:00 PM", "%Y/%m/%d %I:%M%p")
#puts OpportunityDBHandler.new.dbconnection
