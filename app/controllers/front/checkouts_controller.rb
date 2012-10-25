class Front::CheckoutsController < InheritedResources::Base
  
  
  def new
    if @current_order.tickets.count == 0
      redirect_to '/page/calendar', :notice => 'You have no items in your Shopping Cart!'
    end
  end
  
  # POST /checkout
  def create

    @checkout = Checkout.new({
      :user_first_name => params[:user][:first_name],
      :user_last_name => params[:user][:last_name],
      :user_email => params[:user][:email],
      :card_number => params[:credit_card][:card_number],
      :card_expiration_month => params[:credit_card][:"expiration(2i)"],
      :card_expiration_year => params[:credit_card][:"expiration(1i)"],
      :card_cvv => params[:credit_card][:cvv],
      :address_line_1 => params[:address][:address_line_1],
      :address_line_2 => params[:address][:address_line_2],
      :address_city => params[:address][:city],
      :address_state => params[:address][:state], 
      :address_zip => params[:address][:zip]
    })
    
    
    respond_to do |format|
      if @checkout.valid?
        @order = @current_order

        @checkout.process_order(@order.id)
        if @order
          format.html {
            redirect_to front_order_path(@order)
          }
        else
          flash[:errors] = "Error. Please try again"
          redirect_to '/checkout'
        end
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
