
class PermitmeclientController < ApplicationController
 
  
  def getResult
    @result  = PermitmeclientHelper.getResult()
    render :xml => @result
  end

  def getResultAsJSONString
    @result  =  PermitmeclientHelper.getResultAsJSONString()
    render :xml => @result
  end
  
  def getResultAsXMLStringLinkXSL
    @result  =  PermitmeclientHelper.getResultAsXMLStringLinkXSL()
    render :xml => @result
  end
  
  
end
