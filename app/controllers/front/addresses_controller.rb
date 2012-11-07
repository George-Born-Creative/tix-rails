class Front::AddressesController < InheritedResources::Base
  layout 'front_user'
  before_filter :get_or_create_address
  
  def show
    redirect_to edit_front_address_path(resource)
  end
  
  protected

  def get_or_create_address
    @address = @current_user.address.nil? ? @current_user.create_address : @current_user.address
  end
    
end