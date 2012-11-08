class Front::UsersController < InheritedResources::Base
  layout 'front_user'
  
  def index
    @user = @current_user
    #redirect_to front_user_path(@current_user)
  end

  # POST /users/env(.js)
  def user_env
    rl = user_signed_in? ?  @current_user.role : 'guest'
    order = @current_order.blank? ? nil : Rabl.render(@current_order, 'front/orders/order', :view_path => 'app/views', :format => :hash)#.render#'front/orders/order', :object => @current_order, :format => :json)
  
    respond_to do |format|
      format.js {
        render :json => {:role => rl, :env => ENV['RAILS_ENV'], :order => order}
      }
    end
  end

  # GET /users/my_account
  def my_account
    unless user_signed_in?
      redirect_to sign_in_path, :alert => 'Please sign in first'
      return
    end
    @orders = @current_user.orders
  end


  # POST /users/one_liner(.js)
  def login_env
    respond_to do |format|
      format.json {
        render :json => {:html => render_to_string('front/users/login_env.html.haml') }
      }
    end
  end

  protected

  #def collection
  #   @sidebars ||= end_of_association_chain.order('created_at ASC')
  #end

  def begin_of_association_chain
    @current_account
  end

end

