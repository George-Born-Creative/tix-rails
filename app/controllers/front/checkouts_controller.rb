class Front::CheckoutsController < InheritedResources::Base
  
  def index
    render new
  end
  
  
  # POST /checkout
  def create

    @checkout = Checkout.new({
      :user_first_name => params[:user][:first_name],
      :user_last_name => params[:user][:last_name],
      :user_email => params[:user][:email],
      :card_number => params[:credit_card][:card_number],
      :card_expiration => params[:credit_card][:expiration],
      :card_cvv => params[:credit_card][:cvv],
      :address_line_1 => params[:address][:address_line_1],
      :address_line_2 => params[:address][:address_line_2],
      :address_city => params[:address][:city],
      :address_state => params[:address][:state], 
      :address_zip => params[:address][:zip]
    })
    
    
    respond_to do |format|
      if @checkout.valid?
        format.html { @checkout }
      else
        format.html {
          flash[:error] = @checkout.errors
          flash[:checkout] = @checkout
          
          redirect_to '/checkout'
        }
      end
    end
    
    
    
    
  end
  
end
