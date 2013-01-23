class EventsController < ApplicationController
  respond_to :json, :html
  
  before_filter :populate_artists
  before_filter :set_supporting_acts, :only => [:create, :update]
  
  # GET /events
  # GET /events.json
  def index
    
    respond_to do |format|
      format.json {
        render json: EventDatatable.new(view_context, @current_account.id)
      }
      format.html {
        @events = @current_account.events.where{ (title =~ my{"%#{params[:search]}%"} )}
                      .order('starts_at desc')
                      .page(params[:page])
                      .per(10)
      }
    end
    
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = @current_account.events.find(params[:id])

    # respond_with @event
    render :layout => 'manager'
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = @current_account.events.new(Event.defaults) # TODO, set this account-wid

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = @current_account.events.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'manager'}
    end
  end

  # POST /events
  # POST /events.json
  def create
    params[:event] = convert_datetimes( params[:event] )
    @event = @current_account.events.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = @current_account.events.find(params[:id])
    
    params[:event] = convert_datetimes( params[:event] )
    
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = @current_account.events.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def set_supporting_acts
    if params[:event][:supporting_act_ids_concat].blank?
      params[:event][:supporting_act_ids] = [] 
    else
      params[:event][:supporting_act_ids] = params[:event][:supporting_act_ids_concat].split(',')
    end
    true
  end
  
  def populate_artists
    @artist_options = @current_account.artists.order('name asc').all.collect {|a| [a.name, a.id] }
  end
  
  def convert_datetimes(parameters)
    Event::TIMES.each do |field|
      date = parameters[field][:date]
      time = parameters[field][:time]
      # Bug in Rails http://www.elabs.se/blog/36-working-with-time-zones-in-ruby-on-rails
      # https://github.com/rails/rails/issues/5559
      datetime = ActiveSupport::TimeWithZone.new(nil, Time.zone, Time.strptime("#{date} #{time}", "%m-%d-%Y %I:%M %p"))      
      parameters[field] = datetime
    end
    parameters
  end
    
end
