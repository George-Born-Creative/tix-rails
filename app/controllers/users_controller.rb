class UsersController < InheritedResources::Base
  respond_to :html, :json
  # GET /users
  # GET /users.json
  def index
    
    respond_to do |format|
      
      format.json {
        render json: CustomerDatatable.new(view_context, @current_account.id)
      }
      format.html {
        @users = @current_account.users.with_role(:customers)
                      .where{(first_name =~ "%#{params[:sSearch]}%") | (last_name =~ "%#{params[:sSearch]}%") | (email =~ "%#{params[:sSearch]}%") }
                      .page(params[:page])
                      .per(10)
      }
    end
      
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
      redirect_to '/users/sign_in', :alert => 'Please sign in first'
      return
    end
    @orders = @current_user.orders
  end
  
  
  # POST /users/one_liner(.js)
  def one_liner
    respond_to do |format|
      format.html {
        render 'users/one_liner' 
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

