class GoController < ApplicationController
  
    def index
      @redirect_url = RedirectUrl.find(:first, :select => 'redirect_url', :conditions => ['keyword1 = ?', params[:keyword1]])
      redirect_to @redirect_url["redirect_url"]
    end
end
