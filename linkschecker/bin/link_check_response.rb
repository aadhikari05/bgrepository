class LinkCheckResponse
  attr_accessor :url, :response_code, :time, :redirect_url
  
  def isLive?()
    response_code == "200"
  end
  
end