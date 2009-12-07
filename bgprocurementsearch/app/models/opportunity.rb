class Opportunity < ActiveRecord::Base
  
#  define_index do
#    
#    indexes sol_desc
#    indexes sol_nbr
#    indexes subject
#   
#    has recovery_ind, active_ind
#    
#  end

  def resp_date_formatted
    if(!resp_date.nil?)
      if(resp_date.strftime('%H')=="00")
          resp_date.strftime '%m-%d-%Y'
        else
          resp_date.strftime '%m-%d-%Y %I:%M %p'
      end
    end
  end
  
  def sol_date_formatted
    if(!sol_date.nil?)
      sol_date.strftime '%m-%d-%Y'
    end
  end

  
end
