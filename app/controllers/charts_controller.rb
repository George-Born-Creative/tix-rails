class ChartsController < InheritedResources::Base
  respond_to :json, :html
  def index
    @charts = @current_account.charts.order('created_at desc')
    
    respond_with @charts
  end

  def show
    @chart = @current_account.charts.find(params[:id])
    @sections = Section.where(:chart_id => @chart.id).includes(:areas, :presale_price, :dayof_price)
    
    respond_with @chart
  end
  
  def edit
    @chart = @current_account.charts.find(params[:id])
  end
  
  def show
    @chart = @current_account.charts.find(params[:id])
    redirect_to edit_chart_path(@chart)
  end
  
  
  # GET /charts/:id/clone_for_event/:event_id
  def clone_for_event
    @source_chart = begin_of_association_chain.charts.find( params[:id] )
    @event = begin_of_association_chain.events.find( params[:event_id] )
    
    @chart = @source_chart.copy
    @chart.save!
    @event.chart = @chart
    
    @chart.name = @event.name + ' chart ' + @source_chart.name
    @event.chart = @chart
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event seating chart was successfully cloned.' }
        format.json { render json: @event, status: :created, location: @chart }
      else
        format.html {  }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
        
    end
  end

protected

  def collection
    @charts ||= end_of_association_chain.order('created_at ASC')
  end

  def begin_of_association_chain
    @current_account
  end
  
end
