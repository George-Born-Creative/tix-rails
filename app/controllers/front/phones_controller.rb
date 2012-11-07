class Front::PhonesController < InheritedResources::Base
  layout 'front_user'
  before_filter :get_or_create_phone

  
  def show
    redirect_to edit_front_phone_path(resource)
  end

  
  protected

  def get_or_create_phone
    @phone = @current_user.phone.nil? ? @current_user.create_phone : @current_user.phone
  end
  
end

