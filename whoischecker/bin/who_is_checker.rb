require 'rubygems'
require 'whois'
require "fastercsv"
require "yaml"

class WhoIsChecker
  
  attr_accessor :inputFolder, :outputFolder
  
  # constructor
  def initialize()
    # read the input and output folder location from the config.yml file
    config = YAML::load_file(File.dirname(__FILE__) + "/../config/config.yml");
    self.inputFolder = config['folder_location']['input']
    self.outputFolder = config['folder_location']['output']
  end
  
  # main method to be called each time it runs
  # reads all the csv files in the input folder, checks if a corresponding output file already exists
  # if it does  not then it goes ahead and generates the output file
  def run
    puts Time.now.to_s+" WhoIsChecker ...START"
    if (!inputFolder.nil? && !outputFolder.nil?)
      # check path specified are folders
      if (File.directory?(inputFolder) && File.directory?(outputFolder))
        inputDir = Dir.new(inputFolder)
        outputDir = Dir.new(outputFolder)
        filesInInputDir = inputDir.entries
        # for each input file
        Dir.foreach(inputFolder){ |inputFile| 
          puts inputFile 
          # ends with .csv and outfile file does not exists
          if(inputFile[/.csv$/] && !File.exist?(outputFolder+inputFile))
            # parse each input file and generate the outputfile
            runFile(inputFolder+inputFile,outputFolder+inputFile)
          else
            puts "Either the input file is not in csv format or its already parsed and is in output folder. Hencing skipping file - "+inputFile
          end
          
        }

      else
        puts "input or output folder does not exceed. Cannot proceed further"
      end
    else
      puts "input folder="+inputFolder+"outputFolder="+outputFolder+". Cannot proceed further"
    end
    puts Time.now.to_s+" WhoIsChecker ... END"
  end
  
  # parses the input file and generates the output file
  def runFile(inputFile,outputFile)
    if !inputFile.nil? && !outputFile.nil?
      rowCount = 0
      FasterCSV.open(outputFile, "w") do |csv|
        puts "Working on input file -"+inputFile
        FasterCSV.foreach( inputFile) do  |row|
          if rowCount>0
            # parse each row in the input csv file and create a new row in the output csv file
            csv << parseRow(row)
          else
            csv << [row[0],row[1],"Organization"]
          end
          rowCount = rowCount + 1
          if(rowCount%5==0)
            print "."
          end
        end
      end
      puts "\nGenerated output file -"+outputFile
    end
  end
  
  # parses each row and finds out the organization of each IP address
  # assumes ip address are in the second column
  def parseRow(row)
      if !row.nil? && !row[1].nil?
        orgName = whoIsOrganization(row[1])
        [row[0],row[1], orgName]
      else
        [row[0],row[1], ""]
      end
  end
  
  # gets the whois address
  def whoIsAddress(ipOrDomain)
    a = Whois.query(ipOrDomain)
  end
  
  # gets the who is orgname for IP
  def whoIsOrganization(ipOrDomain)
    a = Whois.query(ipOrDomain)
    parseWhoIsOrg(a.to_s)
  end
  
  def whoIsOrganizationTest(ipOrDomain)
    a = Whois.query(ipOrDomain)
    puts a
  end
  
  # custom parser method to extract the orgname from outputs of different whois server
  # code to handle other servers needs to be added here.
  def parseWhoIsOrg(whoIsInfo)
    org = whoIsInfo
    found = false;
    whoIsInfo.each_line do |line|
      if(line.strip[/^descr:|^Organization|^OrgName:/]  && !found)
        #puts line
        case line.strip
          when /^descr:/ 
            then 
              org = line.strip.split(/^descr:/)[1].to_s.strip
              found  = true
          when /^Organization:/ 
            then 
              org = line.strip.split(/^Organization:/)[1].to_s.strip
              found  = true
          when /^OrgName:/ 
            then 
              org = line.strip.split(/^OrgName:/)[1].to_s.strip
              found  = true
          else
            # do nothing
        end
        #puts org
      end
    end
    if !found
      org = parseMultiARINRecord(whoIsInfo)
    end
    org
  end
  
  def parseMultiARINRecord(whoIsInfo)
    org_names = whoIsInfo
    org_names_array = Array.new
    lineCounter = 0
    whoIsInfo.each_line do |line|
      if lineCounter%2==0 && !line.index("(NET").nil?
        if !org_names_array.include?(line[0..line.index("(NET")-1])
          org_names_array << line[0..line.index("(NET")-1]
        end
      end
      lineCounter = lineCounter+1
    end
    if org_names_array.length >0
      org_names = "";
      org_names_array.each {|x| org_names = org_names+x+"| " }
      org_names = org_names[0..-3]
    end
    #puts org_names
    org_names
  end
  
  
end

WhoIsChecker.new().run
#WhoIsChecker.new().whoIsOrganizationTest('80.212.80.179')
#WhoIsChecker.new().whoIsOrganizationTest('google.it')
#WhoIsChecker.new().whoIsOrganization('12.156.194.3')
#WhoIsChecker.new().whoIsOrganization('130.237.61.137')


