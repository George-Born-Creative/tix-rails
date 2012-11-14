class Front::OrdersController < InheritedResources::Base
  layout 'front_user'
  
  before_filter :set_current_order
  before_filter :authenticate_user!, :except => [:add_to_cart, :remove_from_cart]


  def show
    @order = @current_user.orders.where(:id => params[:id]).first
    
    unless @order
      redirect_to '/', :notice => "You are not authorized to access this order."
    end
    
    respond_to do |format|
      format.html
      format.pdf { doc_raptor_send }
     end
     
    
  end
  
  def new
    
  end

  def add_to_cart # POST /orders/add_to_cart/:area_id 
    area_id = params[:area_id]
    respond_to do |format|
      if @current_order.create_ticket(area_id)
        format.js { render :json => {:message => 'success', :order => @current_order} }
      else
        format.js { render :json => {:message => 'fail'}, :status => :unprocessable_entity }
      end
    end
  end
    

  def remove_from_cart # POST /orders/remove_from_cart/:area_id 
    area_id = params[:area_id]
    @current_order.tickets.find_by_area_id(area_id).delete
    
    respond_to do |format|
      format.html{ redirect_to '/checkout' }
      format.js { render :json => {:message => 'success', :order => @current_order} }
    end
  end
  
  
  
  def doc_raptor_send(options = { })
     default_options = { 
       :name             => controller_name,
       :document_type    => request.format.to_sym,
       :test             => ! Rails.env.production?,
     }
     options = default_options.merge(options)
     options[:document_content] ||= render_to_string
     ext = options[:document_type].to_sym

     response = DocRaptor.create(options)
     if response.code == 200
       send_data response, :filename => "#{options[:name]}.#{ext}", 
                           :type => ext, 
                           :disposition => 'inline'
     else
       render :inline => response.body, :status => response.code
     end
   end
   
  

  private
 
  def collection
     @orders ||= end_of_association_chain.complete.order('purchased_at DESC') # ensure complete orders only
  end

  def begin_of_association_chain
    @current_user
  end
  
  
end
