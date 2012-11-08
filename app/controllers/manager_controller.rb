class ManagerController < ApplicationController
  # before_filter :authenticate_user!
  
  def index     
    redirect_to '/manager/reports'
  end
  
  def settings
    
  end
  

end