require "net/ftp"


class FBOTextFileDownloader

FBO_FTP_SITE = "ftp.fbo.gov"
  attr_accessor :ftp
  def initialize
    self.ftp = Net::FTP.new(FBO_FTP_SITE)
    self.ftp.login
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


# require "fbo_textfile_parser"
# require "opportunitydb_handler"
# downloader = FBOTextFileDownloader.new
# downloader.fileNames.each do |fileName|
#   
#   if fileName[/^FBOFeed/]
#     puts fileName
#     downloader.downloadFile(fileName)
#     c = FBOTextfileParser.new(fileName)
#     c.parse
#     OpportunityDBHandler.new.insertOpportunitiesIntoDB(c.opportunities)
#   end
#   
# end
# 