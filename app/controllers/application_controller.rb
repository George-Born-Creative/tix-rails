class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout
  
  before_filter :set_current_account
  before_filter :set_current_order_if_front
  before_filter :clear_completed_order_if_front
  before_filter :authenticate_admin!
  
  private

  def set_current_account
    # Cases
    
    current_host = "#{request.host}"
    
    # 1. Requesting a root level company domain. Redirect to thinio.com
    
    if ['thintix.com', 'localtix.com', 'litetix.com'].include? current_host
      redirect_to 'http://thinio.com'
      return
    end
    
    # 2. A subdomain of (thintix or localtix).com
    unless current_host.scan(/thintix.com|localtix.com|litetix.com/).empty?
      @current_account = Account.find_by_subdomain(request.subdomains.first)
      return unless @current_account.nil?
    
    # 3. A customer's custom domain name
    
    else
      @current_account = AccountDomain.find_by_domain(current_host).account
      return unless @current_account.nil?
    end

    # If nothing has been found, 404
    raise ActionController::RoutingError.new("'#{current_url}' not found in ThinTix ")
  end

  def layout
    if devise_controller? || action_name == 'sign_in' || action_name == 'sign_up'
     "front_user"
    elsif request.fullpath.slice(0,8) == '/manager'
      "manager"
    elsif request.fullpath.slice(0,6) == '/admin'
      "application"
    else
     "application"
    end  
  end


  def manager_path?
    request.fullpath.slice(0,8) == '/manager'
  end
  
  # def not_found
  #   raise ActionController::RoutingError.new('Not Found')
  # end
  
  def after_sign_in_path_for(resource)
    # if resource.is_a?(User) && resource.has_at_least_role(:employee)
    #   '/manager'
    # else
    #   super
    # end
    if params.has_key?(:after_sign_in_path) 
      params[:after_sign_in_path]
    else
      super
    end
      
    
  end
  
  # def after_sign_in_path_for(resource)                                                                                                                      
  #   sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')                                            
  #   if request.referer == sign_in_url                                                                                                                    
  #     super                                                                                                                                                 
  #   else                                                                                                                                                    
  #     stored_location_for(resource) || request.referer || root_path                                                                                         
  #   end                                                                                                                                                     
  # end
  
  
  def authenticate_admin!
     # Pass if this isn't the manager page
     return true unless manager_path?
     
     # User must be signed in. 
     # If not, redirect to sign in page
     unless user_signed_in? 
       # redirect_to new_user_session first, :notice => 'Must sign in first'
       # return false
       authenticate_user!
     end
     
     # Must be employee or higher
     # If not, take home
     unless current_user.has_at_least_role(:employee)
       redirect_to '/', :notice => 'Insufficient permissions'
       return false       
     end

  end
  
  

  
  
  protected
  
  # CKEDITOR    
  def ckeditor_filebrowser_scope(options = {})
    super({ :assetable_id => @current_account.id, :assetable_type => 'Account' }.merge(options))
  end
  
  def ckeditor_before_create_asset(asset)
    asset.assetable = @current_account
    return true
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  private
  
  def manager_page?
    request.fullpath.slice(0,8) == '/manager'
  end
  
  
  def set_current_order_if_front
    set_current_order() unless manager_path? # only set the current order if front end
  end
  
  
  def clear_completed_order_if_front
    clear_completed_order() unless manager_path? # only clear the current order if front end
  end
  
  
  # If current order is expired, clear stored session order
  # Otherwise, create a new order and attach to current session
  # (Order becomes abandonded (expired_at > Now + LIFESPAN)
  
  def ensure_employee
    unless @current_user.has_at_least_role(:employee)
      redirect_to '/', :notice => 'Only employees of Jammin\' Java may check you in!'
    end
  end
  
  
  def set_current_order
    # For case when order is deleted (mostly in early development) 
    # clear session if order is blank. TODO: remove this

    session[:order_id] = nil if @current_account.orders.where(:id => session[:order_id]).empty?

    if session[:order_id]
      
      @current_order ||= @current_account.orders.find(session[:order_id])
      
      if @current_order.expired? #|| @current_order.purchased_at ||
        if @current_order.tickets.count == 0
          @current_order.destroy
        end
        session[:order_id] = nil
      end  
    end
    
    if session[:order_id].nil?  
      @current_order = @current_account.orders.create!( :ip_address => request.remote_ip)
      session[:order_id] ||= @current_order.id  
    end    
    @current_order
  end
  
  def clear_completed_order
    if @current_order.complete?
      order_path = front_order_path(@current_order)
      session[:success_order_id] = session[:order_id]
      session[:order_id] = nil
      redirect_to '/orders/success'
    end
  end
  
  



end
