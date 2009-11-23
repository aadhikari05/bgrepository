module PermitmeclientHelper
  include HTTParty
  #base_uri 'bgaws0:3000/permitme'
  #default_params :output => 'xml'
  #format :json
  
  def self.getResult
    #format :xml
    get('http://bgaws0:3000/permitme/state_only/child%20care%20services/il.xml')
  end

  def self.getResultAsJSONString
    #format :json
    get('http://bgaws0:3000/permitme/state_only/child%20care%20services/il.json')
  end
  
  def self.getResultAsXMLStringLinkXSL
    #format :xml
    insertXSL(get('http://bgaws0:3000/permitme/state_only/child%20care%20services/il.xml').to_xml({:root => 'result'}))
  end
  
  def self.insertXSL(xmlResult)
    @outputString = ''
    @xslURL  = 'PermitMe.xsl';
    @index = xmlResult.index('<result>')
    if  @index >=0
      @outputString = xmlResult.slice(0,@index)+"<?xml-stylesheet type='text/xsl' href='"+@xslURL+"' ?>"+xmlResult.slice(@index, xmlResult.length())
    end
    @outputString
  end
end
