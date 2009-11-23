class Opportunity
  attr_accessor :sol_type, :sol_date, :agency, :agency_office, :agency_location, :agency_zip, :agency_office_address, :classcode, :naics, \
                :subject, :sol_nbr, :resp_date, :archive_date, :archive_policy, :sol_desc, :link_url, :link_desc, :contact, :contact_email, \
                :contact_email_desc, :setaside, :pop_address, :pop_zip, :pop_country, :pop_state, :active_ind, :recovery_ind, :link_tag, :email_tag
  
  
  def setFieldValueFromLine(line)
    
    case line
      when /^<DATE>/    
        then self.sol_date = line.split(/^<DATE>/)[1].to_s.gsub!(/\n+/, "")
      when /^<YEAR>/    
        then self.sol_date = (self.sol_date.to_s+line.split(/^<YEAR>/)[1].to_s).gsub!(/\n+/, "")
      when /^<AGENCY>/  
        then self.agency = line.split(/^<AGENCY>/)[1].to_s.gsub!(/\n+/, "")
      when /^<OFFICE>/  
        then self.agency_office = line.split(/^<OFFICE>/)[1].to_s.gsub!(/\n+/, "")
      when /^<LOCATION>/  
        then self.agency_location = line.split(/^<LOCATION>/)[1].to_s.gsub!(/\n+/, "")
      when /^<ZIP>/  
        then self.agency_zip = line.split(/^<ZIP>/)[1].to_s.gsub!(/\n+/, "")
      when /^<CLASSCOD>/  
        then self.classcode = line.split(/^<CLASSCOD>/)[1].to_s.gsub!(/\n+/, "")
      when /^<NAICS>/  
        then self.naics = line.split(/^<NAICS>/)[1].to_s.gsub!(/\n+/, "")
      when /^<OFFADD>/  
        then self.agency_office_address = line.split(/^<OFFADD>/)[1].to_s.gsub!(/\n+/, "")
      when /^<SUBJECT>/  
        then self.subject = line.split(/^<SUBJECT>/)[1].to_s.gsub!(/\n+/, "")
      when /^<SOLNBR>/  
        then self.sol_nbr = line.split(/^<SOLNBR>/)[1].to_s.gsub!(/\n+/, "")
      when /^<RESPDATE>/  
        then self.resp_date = line.split(/^<RESPDATE>/)[1].to_s.gsub!(/\n+/, "")
      when /^<ARCHDATE>/  
        then self.archive_date = line.split(/^<ARCHDATE>/)[1].to_s.gsub!(/\n+/, "")
      when /^<CONTACT>/  
        then self.contact = line.split(/^<CONTACT>/)[1].to_s.gsub!(/\n+/, "")
      when /^<DESC>/  
        then
          if link_tag==true
            self.link_desc = line.split(/^<DESC>/)[1].to_s.gsub!(/\n+/, "")
            self.link_tag = false
          elsif email_tag==true
            self.contact_email_desc = line.split(/^<DESC>/)[1].to_s.gsub!(/\n+/, "")
            self.email_tag = false
          else
            self.sol_desc = line.split(/^<DESC>/)[1].to_s.gsub!(/\n+/, "")
          end
      when /^<LINK>/  
        then self.link_tag = true
      when /^<URL>/  
        then self.link_url = line.split(/^<URL>/)[1].to_s.gsub!(/\n+/, "")
      when /^<EMAIL>/  
        then self.email_tag = true
      when /^<ADDRESS>/  
        then self.contact_email = line.split(/^<ADDRESS>/)[1].to_s.gsub!(/\n+/, "")
      when /^<SETASIDE>/  
        then self.setaside = line.split(/^<SETASIDE>/)[1].to_s.gsub!(/\n+/, "")
      when /^<POPADDRESS>/  
        then self.pop_address = line.split(/^<POPADDRESS>/)[1].to_s.gsub!(/\n+/, "") 
      when /^<POPZIP>/  
        then self.pop_zip = line.split(/^<POPZIP>/)[1].to_s.gsub!(/\n+/, "")
      when /^<POPCOUNTRY>/  
        then self.pop_country = line.split(/^<POPCOUNTRY>/)[1].to_s.gsub!(/\n+/, "")
        
 
      else #puts "Nothing"
    end

    self
end

#def inspect
#  "Opportunity[type:#{type},date:#{date},agency:#{agency},link_desc:#{link_desc},contact_email_desc:#{contact_email_desc}]"
#end

def to_s
  "Opportunity[type:#{sol_type},date:#{sol_date},pop_zip:#{pop_zip},pop_address:#{pop_address},agency:#{agency},link_desc:#{link_desc},contact_email_desc:#{contact_email_desc}]"
end
  
end