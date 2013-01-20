class ManagerController < ApplicationController
  # before_filter :authenticate_user!
  
  def index     
    redirect_to '/manager/reports/event_totals'
  end
  
  def settings
    
  end
  

end