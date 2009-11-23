require 'rubygems'
require 'open-uri'
require 'json'
require 'address'


class AddressParser
  GOOGLE_MAPS_HTTP_URI = 'http://maps.google.com/maps/geo?q='
  attr_accessor :address
  
  def initialize(address)
    self.address = address
  end
  
  def parse
    address = Address.new
    
    addressObj = parseJSON googleAddressInJSON
    countryObj = findCountryObj(addressObj)
    adminAreaObj = findAdminAreaObject(countryObj)
    localityObj = findLocalityObject(adminAreaObj)
    
    address.street = parseStreet(localityObj)
    address.city = parseCity(localityObj)
    address.state =  parseState(adminAreaObj)
    address.zip = parseZip(adminAreaObj,localityObj)
    address.country = parseCountry(countryObj)
    
    address
  end
  
  def parseStreet(localityObj)
     if !localityObj.nil? &&
      !localityObj['Thoroughfare'].nil?  &&
      !localityObj['Thoroughfare']['ThoroughfareName'].nil?
    
      localityObj['Thoroughfare']['ThoroughfareName']
    else
      ""
    end
  end
  
   def parseCity(localityObj)
    if !localityObj.nil? &&
      !localityObj['LocalityName'].nil? 
     
      localityObj['LocalityName']
    else
      ""
    end
  end
  
  def parseState(adminAreaObj)
    if !adminAreaObj.nil? &&
      !adminAreaObj['AdministrativeAreaName'].nil? 
     
      adminAreaObj['AdministrativeAreaName']
    else
      ""
    end
  end
  
  def parseZip(adminAreaObj,localityObj)
    if !localityObj.nil? &&
      !localityObj['PostalCode'].nil?  &&
      !localityObj['PostalCode']['PostalCodeNumber'].nil?
    
      localityObj['PostalCode']['PostalCodeNumber']
    elsif !adminAreaObj.nil? &&
      !adminAreaObj['SubAdministrativeArea'].nil? &&
      !adminAreaObj['SubAdministrativeArea']['PostalCode'].nil?  &&
      !adminAreaObj['SubAdministrativeArea']['PostalCode']['PostalCodeNumber'].nil?
    
      adminAreaObj['SubAdministrativeArea']['PostalCode']['PostalCodeNumber']
    
    else
      ""
    end
  end
  
  def parseCountry(countryObj)
    if !countryObj.nil? &&
      !countryObj['CountryNameCode'].nil?
     
      countryObj['CountryNameCode']
    else
      ""
    end
  end
  
  
  def findCountryObj(addressObj)
    if !addressObj.nil? && 
      !addressObj['Placemark'].nil? && 
      addressObj['Placemark'].length==1 && 
      !addressObj['Placemark'][0]['AddressDetails'].nil? &&
      !addressObj['Placemark'][0]['AddressDetails']['Country'].nil?
      
      addressObj['Placemark'][0]['AddressDetails']['Country']
    end
  end  
  
  def findAdminAreaObject(countryObj)
    if !countryObj.nil? && 
      !countryObj['AdministrativeArea'].nil?
      countryObj['AdministrativeArea']
    end
  end 
  
  def findLocalityObject(adminAreaObj)
    if !adminAreaObj.nil? && 
      !adminAreaObj['SubAdministrativeArea'].nil? &&
      !adminAreaObj['SubAdministrativeArea']['Locality'].nil?
      adminAreaObj['SubAdministrativeArea']['Locality']
    end
  end  
  
  def googleAddressInJSON
    #puts ">>"+URI.escape(GOOGLE_MAPS_HTTP_URI+self.address)+"<<"
    sleep 0.1
    response = URI.parse(URI.escape(GOOGLE_MAPS_HTTP_URI+self.address)).read
    #puts response
    response
  end
  
  def parseJSON jsonObj
    JSON.parse  jsonObj
  end
  
  

end

#puts AddressParser.new("92155").parse