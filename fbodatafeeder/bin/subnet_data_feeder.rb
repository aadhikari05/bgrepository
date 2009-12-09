require 'opportunity'
require 'opportunitydb_handler'

class SubnetDataFeeder
  
  def parse(textFilePath)
    opportunity = Opportunity.new
    opportunity.sol_type='SUBSOL'
    textFile = File.new(textFilePath, "r")
    textFile.each do |line|
      case line
        when /^Prime's Name:/    
          opportunity.agency = line.split(/^Prime's Name:/)[1].to_s.strip
        when /^Address 1:/    
          opportunity.agency_office_address = line.split(/^Address 1:/)[1].to_s.strip
        when /^Contact:/    
          opportunity.contact = line.split(/^Contact:/)[1].to_s.strip
        when /^Email:/    
          opportunity.contact_email = line.split(/^Email:/)[1].to_s.strip
        when /^Seeking:/    
          opportunity.setaside = line.split(/^Seeking:/)[1].to_s.strip
          opportunity.setaside = opportunity.setaside.gsub('US Department Of Transportation Disadvantaged Business Enterprise (DBE)','Disadvantaged Business Enterprise')
          opportunity.setaside = opportunity.setaside.gsub('Small Disadvantaged Business (SDB)','Total Small Disadvantage Business')
          opportunity.setaside = opportunity.setaside.gsub('Women Owned Small Business (WOSB)','Women Owned Small Business')
          opportunity.setaside = opportunity.setaside.gsub('Hubzone Small Business (HUBZSB)','HUBZone')
          opportunity.setaside = opportunity.setaside.gsub('Veteran Owned Small Business (VOSB)','Veteran-Owned Small Business')
          opportunity.setaside = opportunity.setaside.gsub('Historically Black Colleges and Universities and Minority Institutions (HBCU & MI)','Total HBCU / MI')
          opportunity.setaside = opportunity.setaside.gsub('Other Small Business','Total Small Busine')
          opportunity.setaside = opportunity.setaside.gsub('Service-Disabled Veteran-Owned Small Business(SD-VOSB)','Service-Disabled Veteran-Owned Small Business')
          
        when /^Description:/    
          opportunity.sol_desc = line.split(/^Description:/)[1].to_s.strip
          opportunity.subject = opportunity.sol_desc
        when /^NAICS Code:/    
          opportunity.naics = line.split(/^NAICS Code:/)[1].to_s.strip
        when /^Place of performance:/    
          opportunity.pop_state = line.split(/^Place of performance:/)[1].to_s.strip
        when /^Prime Sol. Number:/    
          opportunity.prime_sol_nbr = line.split(/^Prime Sol. Number:/)[1].to_s.strip
        when /^Subcontract Sol. Number:/    
          opportunity.sol_nbr = line.split(/^Subcontract Sol. Number:/)[1].to_s.strip
        when /^Bid Closing Date:/    
          opportunity.resp_date = line.split(/^Bid Closing Date:/)[1].to_s.strip
        else #puts "Nothing"
      end 
    end
    puts opportunity
    insertOpportunityIntoDB(opportunity)
  end
  
  def insertOpportunityIntoDB(opportunity)
    opportunities  = Array.new
    opportunities << opportunity
    OpportunityDBHandler.new.insertOpportunitiesIntoDB(opportunities)
  end
  
end
SubnetDataFeeder.new.parse(File.dirname(__FILE__) +'/../subnet_data/subnet_record.txt')
SubnetDataFeeder.new.parse(File.dirname(__FILE__) +'/../subnet_data/subnet_record1.txt')
SubnetDataFeeder.new.parse(File.dirname(__FILE__) +'/../subnet_data/subnet_record2.txt')
SubnetDataFeeder.new.parse(File.dirname(__FILE__) +'/../subnet_data/subnet_record3.txt')
SubnetDataFeeder.new.parse(File.dirname(__FILE__) +'/../subnet_data/subnet_record4.txt')
SubnetDataFeeder.new.parse(File.dirname(__FILE__) +'/../subnet_data/subnet_record5.txt')
SubnetDataFeeder.new.parse(File.dirname(__FILE__) +'/../subnet_data/subnet_record6.txt')
SubnetDataFeeder.new.parse(File.dirname(__FILE__) +'/../subnet_data/subnet_record7.txt')
SubnetDataFeeder.new.parse(File.dirname(__FILE__) +'/../subnet_data/subnet_record8.txt')
SubnetDataFeeder.new.parse(File.dirname(__FILE__) +'/../subnet_data/subnet_record9.txt')
SubnetDataFeeder.new.parse(File.dirname(__FILE__) +'/../subnet_data/subnet_record10.txt')