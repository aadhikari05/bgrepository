require File.dirname(__FILE__) + "/opportunity"
require "address_parser"

class FBOTextfileParser
  
  attr_accessor :textFile, :generatedRegEx, :opportunities
  ACCEPTED_TYPE_TAGS = ["<PRESOL>","<COMBINE>","<SRCSGT>","<AMDCSS>","<MOD>","<SNOTE>"]
  
  def initialize(textFilePath)
    self.textFile = File.new(textFilePath, "r")
    generateRegEx()
    self.opportunities = Array.new
  end
  
  def parse
    if !textFile.nil?
      textFile.each do |line|
        if lineStartsWithAcceptedTags(line)
          if opportunities.length>0
            puts opportunities[opportunities.length-1]
            opportunities[opportunities.length-1] = set_pop_state(opportunities[opportunities.length-1])
          end
          opps = Opportunity.new
          opps.sol_type = line[1..-3]
          opportunities << opps
        elsif  opportunities.length>0
          opportunities[opportunities.length-1] = opportunities[opportunities.length-1].setFieldValueFromLine(line)
        end
      end
      textFile.close
      if opportunities.length>0
        opportunities[opportunities.length-1] = set_pop_state(opportunities[opportunities.length-1])
      end
      puts "TOTAL OPPS READ = "+ opportunities.length.to_s
    end
  end
 
  private
  
  def lineStartsWithAcceptedTags(line)
      line.match(generatedRegEx)
  end
  
  def generateRegEx
    @regExVal = ""
    ACCEPTED_TYPE_TAGS.each_with_index { |tag, i| @regExVal=@regExVal+"^"+tag+"|" }
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

 # test the class here
# c = FBOTextfileParser.new("/Users/corpcom/Work/FBOFeed20091108")
# c.parse