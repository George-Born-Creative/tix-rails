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
      :card_expiration => params[:credit_card][:expiration],
      :card_cvv => params[:credit_card][:cvv],
      :address_line_1 => params[:address][:address_line_1],
      :address_line_2 => params[:address][:address_line_2],
      :address_city => params[:address][:city],
      :address_state => params[:address][:state], 
      :address_zip => params[:address][:zip]
    })
    
    
    respond_to do |format|
      @order = @current_order

      if @checkout.valid?
        
        @order.update_attributes({
          :first_name => @checkout.user_first_name,
          :last_name => @checkout.user_last_name,
          :email => @checkout.user_email,
          :card_expiration_year => @checkout.card_expiration_year,
          :card_expiration_month => @checkout.card_expiration_month
        })
        
        @order.create_address({
          :address_line_1 => @checkout.address_line_1,
           :address_line_2 => @checkout.address_line_2,
           :city => @checkout.address_city,
           :state => @checkout.address_state,
           :zip => @checkout.address_zip
        })
        
        @order.card_number = @checkout.card_number
        @order.card_verification = @checkout.card_cvv
        
        
        if @order.purchase
          format.html { redirect_to front_order_path(@order), :notice => 'Order processed successfully' }
        else
          flash[:message] = @order.errors.reduce(""){|err| "<p>#{err}</p>"}
          #flash[:error] = "Error processing (123)"
          redirect_to '/checkout'
        end
        
      else # Checkout object did not pass validation
        format.html {
          flash[:error] = @checkout.errors
          flash[:checkout] = @checkout
          redirect_to '/checkout'
        }
      end
    end
    
  end
  
  
  private
  
  
  
end
