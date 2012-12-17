class Front::UsersController < InheritedResources::Base
  layout 'front_user'
  skip_before_filter :verify_authenticity_token, :only => [:login_env, :user_env, :tokens]
  
  def index
    @user = @current_user
    redirect_to front_orders_path #'/orders'# front_user_path(@current_user)
  end

  # POST /users/user_env(.js)
  def user_env
    rl = user_signed_in? ?  @current_user.role : 'guest'
    order = @current_order.blank? ? nil : Rabl.render(@current_order, 'front/orders/order', :view_path => 'app/views', :format => :hash)#.render#'front/orders/order', :object => @current_order, :format => :json)
  
    respond_to do |format|
      format.js {
        render :json => {:role => rl, :env => ENV['RAILS_ENV'], :order => order}
      }
    end
  end

  # POST /users/one_liner(.js)
  def login_env
    respond_to do |format|
      format.json {
        render :json => {:html => render_to_string('front/users/login_env.html.haml') }
      }
    end
  end
  
  # POST /users/tokens.
  def tokens
    respond_to do |format|
      format.json
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

