require "net/ftp"

class FBORecoveryFileDownloader
  attr_accessor :ftp
  FBO_FTP_SITE = "ftp.fbo.gov"
  
  def initialize
    self.ftp = Net::FTP.new(FBO_FTP_SITE)
    self.ftp.login
    self.ftp.chdir("FBORecovery")
  end
  
  def fileNames
    ftp.nlst
   end
 
  def downloadFile(fileName)
    ftp.getbinaryfile(fileName, fileName, 1024)
  end
  
  def close
    ftp.close if ftp
  end
end

# require "fbo_recovery_file_parser"
# require "opportunitydb_handler"
# downloader = FBORecoveryFileDownloader.new
# downloader.fileNames.each do |fileName|
#   
#   if fileName[/^FBORecovery/]
#     puts fileName
#     downloader.downloadFile(fileName)
#     c = FBORecoveryFileParser.new(fileName)
#     c.parse
#     OpportunityDBHandler.new.insertOpportunitiesIntoDB(c.opportunities)
#     File.delete(fileName)
#   end
# end
# downloader.close
 