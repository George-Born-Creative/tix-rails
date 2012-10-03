class ManagerController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin!
  
  def index     
   
  end
  def settings
    
  end
  
  def authenticate_admin!
    if (! user_signed_in? )
      raise 'Must sign in first'
    elsif !(current_user.has_at_least_role(:employee))
      redirect_to '/', :notice => 'Insufficient role '
    else
      true
    end
  end

end