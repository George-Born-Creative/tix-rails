class Front::CheckoutsController < InheritedResources::Base
  before_filter :ensure_order
  
  def new
  end
  
  # Register
  
  # POST /checkout
  def create
    
    @checkout = Checkout.new({
      :user_first_name => params[:user][:first_name],
      :user_last_name => params[:user][:last_name],
      :user_email => params[:user][:email],
      :card_number => params[:credit_card][:card_number],
      :card_expiration_month => convert_date(params[:credit_card], :expires).month,
      :card_expiration_year => convert_date(params[:credit_card], :expires).year,
      :card_cvv => params[:credit_card][:cvv],
      :address_line_1 => params[:address][:address_line_1],
      :address_line_2 => params[:address][:address_line_2],
      :address_city => params[:address][:city],
      :address_state => params[:address][:state], 
      :address_zip => params[:address][:zip],
      :phone_number => params[:phone][:number]
    })
    
    @order = @current_order
    
    set_order_attributes() #on @order with @checkout
    
    respond_to do |format|
      format.html{ 
        if @checkout.valid?
          if @order.purchase(@current_user)
            redirect_to '/orders/success', :notice => 'Order successful!'
            
          else
            flash[:message] = @order.transactions.first.message
            flash[:checkout] = @checkout
            
            render 'new' #'/checkout'
          end
        else # Checkout object did not pass validation
          flash[:error] = @checkout.errors
          flash[:checkout] = @checkout
          redirect_to '/checkout'
        end
      }
    end
    
  end
  
  
  private
  
  def set_order_attributes
   @order.update_attributes({
      :first_name => @checkout.user_first_name,
      :last_name => @checkout.user_last_name,
      :email => @checkout.user_email,
      :card_expiration_year => @checkout.card_expiration_year,
      :card_expiration_month => @checkout.card_expiration_month,
      
    })
    
    @order.create_address({
      :address_line_1 => @checkout.address_line_1,
       :address_line_2 => @checkout.address_line_2,
       :city => @checkout.address_city,
       :state => @checkout.address_state,
       :zip => @checkout.address_zip
    })
    
    @order.create_phone({
      :number => @checkout.phone_number,
      
    })
    
    @order.card_number = @checkout.card_number
    @order.card_verification = @checkout.card_cvv
    
  end
  
  private
  
  def ensure_order
    if @current_order.tickets.count == 0
      redirect_to '/page/calendar', :notice => 'You have no items in your Shopping Cart!'
    end
    
  end
  
  private

  def convert_date(hash, date_symbol_or_string)
    attribute = date_symbol_or_string.to_s
    return Date.new(hash[attribute + '(1i)'].to_i, hash[attribute + '(2i)'].to_i, hash[attribute + '(3i)'].to_i)   
  end

  
end
