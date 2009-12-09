class LinkCheckResponse
  attr_accessor :url, :response_code, :time
  
  def isLive?()
    response_code == "200"
  end
  
end