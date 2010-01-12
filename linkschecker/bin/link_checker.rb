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
        init_res_code = ""
        timeout(10) do
          res = Net::HTTP.get_response(uri) 
          init_res_code = res.code
          redirect_location = ""
          while (res.code=="301" || res.code=="302") do
            redirect_location = res['location'];
            if(!redirect_location[/^http/])
              if(redirect_location[/^\//])  
                if uri_base.index('/',10).nil?
                  redirect_location = uri_base.strip+redirect_location
                else
                  redirect_location = uri_base[0..uri_base.index('/',10)-1].strip+redirect_location
                end
                
              else
                redirect_location = uri_base+redirect_location
              end
            else
              if(redirect_location.rindex('/')>10)
                uri_base = redirect_location[0..redirect_location.rindex('/')].strip
              else
                uri_base = redirect_location
              end
            end
            puts redirect_location +" - "+ uri_base
            uri =  URI.parse(URI.escape(redirect_location))
            res = Net::HTTP.get_response(uri)
          end
          if(init_res_code=="301" || init_res_code=="302")
            link_check_response.response_code = init_res_code
            link_check_response.redirect_url = redirect_location
          else
            link_check_response.response_code = res.code
          end
          link_check_response.time = Time.new
        end # time out block
      rescue TimeoutError => e
        link_check_response.response_code = "TimeoutError"
        link_check_response.time = Time.new
        #puts e.to_s+"-"+url
      rescue URI::BadURIError => e
        link_check_response.response_code = "BadURIError"
        link_check_response.time = Time.new
        #puts e.to_s+"-"+url
      rescue URI::InvalidURIError => e
        link_check_response.response_code = "InvalidURIError"
        link_check_response.time = Time.new
        #puts e.to_s+"-"+url
      rescue Net::HTTPBadResponse => e
        link_check_response.response_code = "HTTPBadResponse"
        link_check_response.time = Time.new
        #puts e.to_s+"-"+url
      rescue Exception => e
        link_check_response.response_code = e.to_s
        link_check_response.time = Time.new
        #puts e.to_s+"-"+url
      else
        #puts "some other error"
      end
    end
    puts link_check_response.response_code+"-"+url.to_s
    return link_check_response
  end
  


end


#LinkChecker.check("http://www.southernshores.org/")


