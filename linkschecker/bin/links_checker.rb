require "rubygems"
require "mysql"
require "db_connect"
require "link_checker"
require "link_check_response"
require "link"
class LinksChecker
  
  include DBConnect
  
  def run
    #brokenLinks = Array.new
    puts Time.new.to_s+" Links Checker Start..."
    puts "Start Sites"
    sites.each  do |link|
      check_link(link)
    end
    puts "End Sites"
    puts "Start Permitme Sites"
    permitme_sites.each  do |link|
     check_link(link)
    end
    puts "End Permitme Sites"
    puts "Start Recommended Site Urls"
    recommended_site_urls.each  do |link|
     check_link(link)
    end
    puts "End Recommended Site Urls"
    puts "Start Grant Loans"
    grant_loans.each  do |link|
      check_link(link)
    end
    puts "End Grant Loans"
    puts "Start Permitme"
    permitme_resources.each  do |link|
      check_link(link)
    end
    puts "End Permitme"
    puts "Start State Recommended Sites"
    state_recommended_sites.each  do |link|
      check_link(link)
    end
    puts "End State Recommended Sites"
    #puts brokenLinks.length
    puts Time.new.to_s+" ... Links Checker END"
  end
  
  
 private
  def check_link(link)
    check_response = LinkChecker.check(link.url)
    if(!check_response.isLive?)
      link.checker_response_code = check_response.response_code
      link.redirect_url = check_response.redirect_url
      puts link.unique_id+"-"+link.url.to_s+"-"+link.checker_response_code
      if broken_link_exist?(link)
        update_broken_link(link)  
      else
        create_broken_link(link)  
      end
      #brokenLinks << link
    else
      if broken_link_exist?(link)
        delete_broken_link(link)  
      end
    end
    
  end
  
  def sites
     links = Array.new
     # connect to the MySQL server
     dbh = dbconnection
     # get server version string and display it
     #puts "Server version: " + dbh.get_server_info
     result = dbh.query("select id,url,name from sites")
     result.each do |row|
       link = Link.new
       link.group = "FEATURES"
       link.table_name = "SITES"
       link.unique_id = row[0]
       link.url = row[1]
       link.description = row[2]
        #puts row[0]
        links << link
     end
     result.free
     links
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      # disconnect from server
      dbh.close if dbh
  end
  
  def permitme_sites
     links = Array.new
     # connect to the MySQL server
     dbh = dbconnection
     # get server version string and display it
     #puts "Server version: " + dbh.get_server_info
     result = dbh.query("select id,url,name from permitme_sites")
     result.each do |row|
       link = Link.new
       link.group = "FEATURES"
       link.table_name = "PERMITME_SITES"
       link.unique_id = row[0]
       link.url = row[1]
       link.description = row[2]
        #puts row[0]
        links << link
     end
     result.free
     links
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      # disconnect from server
      dbh.close if dbh
  end
  
  def recommended_site_urls
     links = Array.new
     # connect to the MySQL server
     dbh = dbconnection
     # get server version string and display it
     #puts "Server version: " + dbh.get_server_info
     result = dbh.query("select id,url from recommended_site_url")
     result.each do |row|
       link = Link.new
       link.group = "FEATURES"
       link.table_name = "RECOMMENDED_SITE_URL"
       link.unique_id = row[0]
       link.url = row[1]
       link.description = ""
        #puts row[0]
        links << link
     end
     result.free
     links
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      # disconnect from server
      dbh.close if dbh
  end
  
  def grant_loans
     links = Array.new
     # connect to the MySQL server
     dbh = dbconnection
     # get server version string and display it
     #puts "Server version: " + dbh.get_server_info
     result = dbh.query("select id,url,title from grant_loans")
     result.each do |row|
       link = Link.new
       link.group = "GRANT_LOANS"
       link.table_name = "GRANT_LOANS"
       link.unique_id = row[0]
       link.url = row[1]
       link.description = row[2]
        #puts row[0]
        links << link
     end
     result.free
     links
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      # disconnect from server
      dbh.close if dbh
  end
  
  def permitme_resources
     links = Array.new
     # connect to the MySQL server
     dbh = dbconnection
     # get server version string and display it
     #puts "Server version: " + dbh.get_server_info
     result = dbh.query("select id,url,link_title from permitme_resources")
     result.each do |row|
       link = Link.new
       link.group = "STATES"
       link.table_name = "PERMITME_RESOURCES"
       link.unique_id = row[0]
       link.url = row[1]
       link.description = row[2]
        #puts row[0]
        links << link
     end
     result.free
     links
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      # disconnect from server
      dbh.close if dbh
  end
  
  def state_recommended_sites
     links = Array.new
     # connect to the MySQL server
     dbh = dbconnection
     # get server version string and display it
     #puts "Server version: " + dbh.get_server_info
     result = dbh.query("select id,url,title from state_recommended_sites")
     result.each do |row|
       link = Link.new
       link.group = "STATES"
       link.table_name = "STATE_RECOMMENDED_SITES"
       link.unique_id = row[0]
       link.url = row[1]
       link.description = row[2]
        #puts row[0]
        links << link
     end
     result.free
     links
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      # disconnect from server
      dbh.close if dbh
  end
  
  
  
  def create_broken_link(link)
    # connect to the MySQL server
     dbh = dbconnection
     # get server version string and display it
     #puts "Server version: " + dbh.get_server_info
     dbh.query("INSERT INTO broken_links (url,description,response_code,table_name,group_name,unique_id,redirect_url,created_at,updated_at) VALUES ('"+link.url.to_s+"','"+Mysql.quote(link.description.to_s)+"','"+link.checker_response_code.to_s+"','"+link.table_name+"','"+link.group+"','"+link.unique_id+"','"+link.redirect_url.to_s+"',current_timestamp,current_timestamp)")
     puts "Number of rows inserted: #{dbh.affected_rows}"
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      # disconnect from server
      dbh.close if dbh
  end
  
  def update_broken_link(link)
    # connect to the MySQL server
     dbh = dbconnection
     # get server version string and display it
     #puts "Server version: " + dbh.get_server_info
     dbh.query("UPDATE broken_links  SET url='#{link.url.to_s}', description='#{Mysql.quote(link.description.to_s)}', response_code='#{link.checker_response_code.to_s}', group_name='#{link.group}',redirect_url='#{link.redirect_url.to_s}', updated_at=current_timestamp  WHERE table_name='#{link.table_name}' AND unique_id='#{link.unique_id}'")
     puts "Number of rows updated: #{dbh.affected_rows}"
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      # disconnect from server
      dbh.close if dbh
  end
  
  def delete_broken_link(link)
    # connect to the MySQL server
     dbh = dbconnection
     # get server version string and display it
     #puts "Server version: " + dbh.get_server_info
     dbh.query("DELETE from broken_links WHERE table_name='#{link.table_name}' AND unique_id='#{link.unique_id}'")
     puts "Number of rows deleted: #{dbh.affected_rows}"
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      # disconnect from server
      dbh.close if dbh
  end
  
  def broken_link_exist?(link)
    exist_flag = false
    # connect to the MySQL server
    dbh = dbconnection
    # get server version string and display it
    #puts "Server version: " + dbh.get_server_info
    if (link.url.nil?)
      link.url = '';
    end
    result = dbh.query("SELECT id FROM broken_links WHERE table_name='#{link.table_name}' AND unique_id='#{link.unique_id}'")
    result.each do |row|
      exist_flag = true
    end
    result.free
    exist_flag 
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      # disconnect from server
      dbh.close if dbh
  end
  
  
  
  
end

LinksChecker.new.run