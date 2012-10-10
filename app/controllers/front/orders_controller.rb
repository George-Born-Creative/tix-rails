class Front::OrdersController < ApplicationController
  
  before_filter :session_order

  def create
    @product = Product.find(params[:ticket_id])
    @order.tickets 
    redirect_to front_order_path(@order)
  end

  def show
    
  end
  
  def new
    
  end



  private
  def session_order
    order_id = session[:order_id]
    @order = session[:order_id] ? @current_account.orders.find(order_id) : @current_account.orders.create
    session[:order_id] = @order.id
  end
  
end
