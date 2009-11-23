require "rubygems"
require "fastercsv"
require "opportunity"
require "address_parser"

class FBORecoveryFileParser
  
  attr_accessor :csvFilePath,:generatedRegEx, :opportunities
  ACCEPTED_TYPE_VALUES = ["Presolicitation","Combined Synopsis","Special Notice","Sources Sought","Solicitation","Modification"]
  def initialize(csvFilePath)
    self.csvFilePath = csvFilePath
    generateRegEx()
    self.opportunities = Array.new
  end
  
  def parse
    if !csvFilePath.nil?
      rowCount = 0
      FasterCSV.foreach(csvFilePath) do  |row|
        if rowCount>0
          parseRow(row)
        end
        rowCount = rowCount + 1
        #puts rowCount
      end
    end
  end
  
  private 
  
  def parseRow(row)
      
      if !row.nil? && row[5].match(generatedRegEx)
        
        sol_type  = row[5]
        case row[5]
          when /^Presolicitation/    
            then 
#              if (!sol_type.index("Modification").nil? && sol_type.index("Modification")>=0) || (!sol_type.index("Cancelled").nil? && sol_type.index("Cancelled")>=0) 
#                sol_type = "MOD"
#              else
                sol_type ="PRESOL"
#              end
          when /^Combined Synopsis|^Solicitation/   
            then
#              if (!sol_type.index("Modification").nil? && sol_type.index("Modification")>=0) || (!sol_type.index("Cancelled").nil? && sol_type.index("Cancelled")>=0)
#                sol_type = "AMDCSS"
#              else
                sol_type ="COMBINE"
#              end
          when /^Special Notice/  
            then sol_type = "SNOTE"
          when /^Sources Sought/  
            then sol_type = "SRCSGT"
          when /^Modification/  
            then sol_type = "MOD"
          else #do "Nothing"
        end
        
        opportunity = Opportunity.new
        opportunity.subject = row[0]
        opportunity.sol_nbr = row[1]
        opportunity.agency = row[2]
        opportunity.agency_office = row[3]
        opportunity.agency_location = row[4]
        opportunity.sol_type = sol_type
        #opportunity.type = row[6]
        opportunity.sol_date = row[7]
        #opportunity.type = row[8]
        opportunity.resp_date = row[9]
        opportunity.archive_policy = row[10]
        opportunity.archive_date = row[11]
        opportunity.setaside = row[12]
        opportunity.classcode = row[13]
        opportunity.naics = row[14]
        opportunity.agency_office_address = row[15]
        opportunity.contact = row[16]
        opportunity.pop_address = row[17]
        opportunity.link_url = row[18]
        opportunity.sol_desc = row[19]
        opportunity.active_ind = row[20]
        #opportunity.type = row[21]
        opportunity.recovery_ind = "true"
        
        opportunity =  set_pop_state opportunity
        
       self.opportunities << opportunity
       
    else
       #puts "Row skipped - type- "+row[5]
   end
   
    
  end
  
  def generateRegEx
    @regExVal = ""
    ACCEPTED_TYPE_VALUES.each_with_index { |tag, i| @regExVal=@regExVal+"^"+tag+"|" }
    @regExVal = @regExVal[0..-2]
    puts "REG EX = "+ @regExVal
    self.generatedRegEx = @regExVal
  end
  
  def set_pop_state(opportunity)
  if(!opportunity.nil?)
        if (!opportunity.pop_zip.nil?)
          opportunity.pop_state = AddressParser.new(opportunity.pop_zip.to_s).parse.state 
          puts opportunity.pop_state+"---"+opportunity.pop_zip
        end
        if (opportunity.pop_state=='' && !opportunity.pop_address.nil?)
          opportunity.pop_state = AddressParser.new(opportunity.pop_address).parse.state 
          puts opportunity.pop_state+"---"+opportunity.pop_address
        end
    end
    opportunity
  end
  
  
end


#c = FBORecoveryFileParser.new("/Users/corpcom/Work/FBORecovery20091031.csv")
#c.parse
#puts c.opportunities.length
#puts c.opportunities[c.opportunities.length-1]