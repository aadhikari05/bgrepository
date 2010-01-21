require 'rubygems'
require 'whois'
require "fastercsv"
require "yaml"
require 'fileutils'


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
            #convertToCommaSeperated(inputFolder+inputFile)
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
      user_ids_with_posts = Array.new
      ips_all = Array.new
      ips_with_post = Array.new
      ips_repeated = Array.new
      FasterCSV.foreach( inputFile, {:col_sep => "\t"}) do  |row|
        if rowCount>2
          #puts str_val+","+(str_val.to_i > 0).to_s
          if(!row[5].nil? && binary_to_string(row[5]).to_i > 0)
            user_ids_with_posts << binary_to_string(row[0])
            ips_with_post << binary_to_string(row[6])
          end
          if(ips_all.include?(binary_to_string(row[6])))
            ips_repeated << binary_to_string(row[6])
          else
            ips_all << binary_to_string(row[6])
          end
        end
        rowCount = rowCount+1 
      end
      #puts "PAL="+user_ids_with_posts.to_s
      rowCount = 0
      array_rows = Array.new
      FasterCSV.open(outputFile, "w") do |csv|
        puts "Working on input file -"+inputFile
        FasterCSV.foreach( inputFile, {:col_sep => "\t"}) do  |row|
          if rowCount>2
            # parse each row in the input csv file and create a new row in the output csv file
            if ((user_ids_with_posts.include?(binary_to_string(row[0])) || ips_with_post.include?(binary_to_string(row[6])))&& ips_repeated.include?(binary_to_string(row[6])))
              array_rows  << parseRow(row)
              #csv << parseRow(row)
            end 
          elsif rowCount==1
            csv << [binary_to_string(row[0]),binary_to_string(row[1]),binary_to_string(row[2]),binary_to_string(row[3]),binary_to_string(row[4]),binary_to_string(row[5]),binary_to_string(row[6]),"Organization"]
          else
            csv << [binary_to_string(row[0]),binary_to_string(row[1]),binary_to_string(row[2]),binary_to_string(row[3]),binary_to_string(row[4]),binary_to_string(row[5]),binary_to_string(row[6])]
          end
          rowCount = rowCount + 1
          if(rowCount%5==0)
            print "."
          end
        end
        array_rows = array_rows.sort {|row1,row2| binary_to_string(row1[6]) <=> binary_to_string(row2[6])}
        array_rows.each do |row|
          csv << row
        end
      end
      puts "\nGenerated output file -"+outputFile
    end
  end
  
  
  def convertToCommaSeperated(inputFile)
    tempFile = inputFile+".temp"
    FileUtils.mv(inputFile, tempFile)
    FasterCSV.open(inputFile, "w") do |csv|
      FasterCSV.foreach(tempFile,{ :col_sep=> "\t" }) do  |row|
        csv  << row
      end
    end
  end
  
  
  # parses each row and finds out the organization of each IP address
  # assumes ip address are in the second column
  def parseRow(row)
      if !row.nil? && !row[6].nil?
        orgName = whoIsOrganization(binary_to_string(row[6]))
        [binary_to_string(row[0]),binary_to_string(row[1]),binary_to_string(row[2]),binary_to_string(row[3]),binary_to_string(row[4]),binary_to_string(row[5]),binary_to_string(row[6]), orgName]
      else
        [binary_to_string(row[0]),binary_to_string(row[1]),binary_to_string(row[2]),binary_to_string(row[3]),binary_to_string(row[4]),binary_to_string(row[5]),binary_to_string(row[6]), ""]
      end
  end
  
  # gets the whois address
  def whoIsAddress(ipOrDomain)
    a = Whois.query(ipOrDomain)
  end
  
  
  def to_ascii(binary_str)
    binary_str.gsub(/\s/,'').gsub(/([01]{8})/) { |b| b.to_i(2).chr }
  end
  
  def binary_to_string(binary)
    str_val = "";
    binary.to_s.each_byte do |c|
      if(c.to_i >0)
        str_val =  str_val+c.chr
      end
    end
    str_val
  end


  # gets the who is orgname for IP
  def whoIsOrganization(ipOrDomain)
    org=""  
    client = Whois::Client.new
    client.timeout = 10
    counter = 0
    begin
      counter = counter +1
      a = Whois.query(ipOrDomain)
      org = parseWhoIsOrg(a.to_s)
    rescue TimeoutError => e
      if (counter>3)
        puts ipOrDomain+"--"+e.to_s
        org ="TIMEOUT-ERROR"
      else
        sleep 5
        retry
      end
    rescue Exception => e
      if (counter>3)
        puts ipOrDomain+"--"+e.to_s
        org ="SOME-ERROR-"+e.to_s
      else
        sleep 5
        retry
      end
    end
    org
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
#WhoIsChecker.new().whoIsOrganizationTest('125.60.172.182')
#WhoIsChecker.new().whoIsOrganizationTest('google.it')
#WhoIsChecker.new().whoIsOrganization('12.156.194.3')
#WhoIsChecker.new().whoIsOrganization('130.237.61.137')


