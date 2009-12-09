 require "fbo_textfile_parser"
 require "fbo_text_file_downloader"
 require "fbo_recovery_file_parser"
 require "fbo_recovery_file_downloader"
 require "opportunitydb_handler"
 require "parsed_filedb_handler"
 
 

class FBODataFeeder
  LOAD_DATA_AFTER_DATE = DateTime.strptime("20091120",'%Y%m%d')
  def run
    puts Time.new.to_s+" FBO Data Feeder Start..."
    feedData
    feedRecoveryData
    puts Time.new.to_s+"...FBO Data Feeder END"
  end
  
  
  def fileNameAfterDate(fileName , date)
    returnVal = false;
    if(!fileName.nil? && !date.nil?) 
      returnVal = DateTime.strptime(fileName[-8..-1],'%Y%m%d')>date
    end
    returnVal
  end
  
  def isFeedFile(fileName)
    fileName[/^FBOFeed/]
  end
  
  def isRecoveryFile(fileName)
    fileName[/^FBORecovery/]
  end
  
  private
  
  def feedData
    downloader = FBOTextFileDownloader.new
    parsedFileDBHandler = ParsedFileDBHandler.new
    alreadyParsedFiles = parsedFileDBHandler.alreadyParsedFiles
    downloader.fileNames.each do |fileName|
      if isFeedFile(fileName) && fileNameAfterDate(fileName,LOAD_DATA_AFTER_DATE)
         puts fileName
         if alreadyParsedFiles.include?(fileName)
           puts fileName + " already parsed and stored in database. Hence skipping."
         else
           downloader.downloadFile(fileName)
           c = FBOTextfileParser.new(fileName)
           c.parse
           OpportunityDBHandler.new.insertOpportunitiesIntoDB(c.opportunities)
           File.delete(fileName)
           parsedFileDBHandler.create(fileName,c.opportunities.length.to_s+" Opportunities Parsed and Inserted.")
         end
      end
    end
    downloader.close
  end
  
  def feedRecoveryData
    downloader = FBORecoveryFileDownloader.new
    parsedFileDBHandler = ParsedFileDBHandler.new
    alreadyParsedFiles = parsedFileDBHandler.alreadyParsedFiles
    latestFileName = nil
    downloader.fileNames.each do |fileName|
      if(isRecoveryFile(fileName))
        latestFileName = fileName
      end
    end  
    if !latestFileName.nil?
       puts latestFileName
       if alreadyParsedFiles.include?(latestFileName)
         puts latestFileName + " already parsed and stored in database. Hence skipping."
       else
         downloader.downloadFile(latestFileName)
         c = FBORecoveryFileParser.new(latestFileName)
         c.parse
         oppsDBHandler = OpportunityDBHandler.new
         oppsDBHandler.deleteAllRecoveryRecords
         oppsDBHandler.insertOpportunitiesIntoDB(c.opportunities)
         File.delete(latestFileName)
         parsedFileDBHandler.create(latestFileName,c.opportunities.length.to_s+" Recovery opportunities Parsed and Inserted.")
       end
    end
    downloader.close
  end
  

end

  
FBODataFeeder.new.run
#puts FBODataFeeder.new.fileNameAfterDate("FBORecovery20091109",DateTime.strptime("20091109",'%Y%m%d'))