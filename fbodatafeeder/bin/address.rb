class Address
  attr_accessor  :street ,:city, :state, :zip, :country
  
  def initialize
    self.street = ""
    self.city = ""
    self.state = ""
    self.zip = ""
    self.country = ""
    
  end
  
  def to_s
    street+"\n" +
    city+", "+state+", "+zip+", "+country
  end
  
end
