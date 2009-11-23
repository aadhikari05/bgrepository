require "rubygems"
require "mysql"
require "db_connect"

class ParsedFileDBHandler
  
  include DBConnect
  
  def create(fileName, details)
     # connect to the MySQL server
     dbh = dbconnection
     # get server version string and display it
     #puts "Server version: " + dbh.get_server_info
     dbh.query("INSERT INTO parsed_files (file_name,details,created_at,updated_at) VALUES ('"+fileName+"','"+Mysql.quote(details)+"',current_timestamp,current_timestamp)")
     puts "Number of rows inserted: #{dbh.affected_rows}"
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      # disconnect from server
      dbh.close if dbh
  end
  
  def alreadyParsedFiles
     @files = Array.new
     # connect to the MySQL server
     dbh = dbconnection
     # get server version string and display it
     #puts "Server version: " + dbh.get_server_info
     @result = dbh.query("select file_name from parsed_files")
     @result.each do |row|
        #puts row[0]
        @files << row[0]
     end
     @files
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      # disconnect from server
      dbh.close if dbh
  end
end


#c = ParsedFileDBHandler.new
#c.create("test","this is a test")
#puts c.alreadyParsedFiles
