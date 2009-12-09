require 'rubygems'
require 'net/http'
require 'uri'
require 'mysql'
require 'link_check_response'

class LinkChecker
  
   def self.check(url)
    link_check_response = LinkCheckResponse.new
    link_check_response.url = url;
    link_check_response.response_code = "";
    
    if(!url.nil?)
      res = nil
      begin
        url = URI.escape(url.strip)
        uri = URI.parse(url)
        uri_base = url
        timeout(10) do
  #        Net::HTTP.open_timeout = 5
  #        Net::HTTP.read_timeout = 5
          res = Net::HTTP.get_response(uri) 
#          while (res.code=="301" || res.code=="302") do
#            redirect_location = res['location'];
#            if(!redirect_location[/^http/])
#              redirect_location = uri_base+redirect_location
#            else
#              uri_base = redirect_location[0..redirect_location.rindex('/')].strip
#            end
#            puts redirect_location +" - "+ uri_base
#            uri =  URI.parse(redirect_location)
#            puts uri.path.to_s
#            res = Net::HTTP.get_response(uri)
#          end
          link_check_response.response_code = res.code
          link_check_response.time = Time.new
        end # time out block
      rescue TimeoutError => e
        link_check_response.response_code = e.to_s
        link_check_response.time = Time.new
        puts e.to_s+"-"+url
      rescue Exception => e
        link_check_response.response_code = e.to_s
        link_check_response.time = Time.new
        puts e.to_s+"-"+url
      else
        #puts "some other error"
      end
    end
    puts link_check_response.response_code+"-"+url.to_s
    return link_check_response
  end
  


end


#LinkChecker.check("http://www.grantalabama.com/")
#LinkChecker.check("http://www.ci.boaz.al.us/city/")
#LinkChecker.check("http://www.bridgeportal.org/")
#LinkChecker.check("http://citronellechamber.com/city_of/")
