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
  
end

