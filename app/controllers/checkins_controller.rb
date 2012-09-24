class CheckinsController < ApplicationController
  layout 'checkin'
  
  respond_to :json
  # GET /checkins
  # GET /checkins.json
  def index
    @checkins = @current_account.checkins.all

    respond_with @checkins
  end

  # GET /checkins/1
  # GET /checkins/1.json
  def show
    @checkin = @current_account.checkins.find(params[:id])

    respond_with @checkin
  end

  # GET /checkins/new
  # GET /checkins/new.json
  def new
    @checkin = Checkin.new( :ticket_id => params[:tid] )
    
    respond_to do |format|
      if @checkin.save
        @checkin.status = :success
        format.html # new.html.erb
        format.json { render json: @checkin }
      else
        @checkin.status = :invalid
        format.html
        format.json { render json: @checkin, status: :unprocessable_entity }
      end
    end
  end

  # GET /checkins/1/edit
  def edit
    @checkin = @current_account.checkins.find(params[:id])
  end

  # POST /checkins
  # POST /checkins.json
  def create
    @checkin = @current_account.checkins.new(params[:checkin])

    respond_to do |format|
      if @checkin.save
        format.html { redirect_to @checkin, notice: 'Seating chart was successfully created.' }
        format.json { render json: @checkin, status: :created, location: @checkin }
      else
        format.html { render action: "new" }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /checkins/1
  # PUT /checkins/1.json
  def update
    @checkin = @current_account.checkins.find(params[:id])

    respond_to do |format|
      if @checkin.update_attributes(params[:checkin])
        format.html { redirect_to @checkin, notice: 'Seating chart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkins/1
  # DELETE /checkins/1.json
  def destroy
    @checkin = @current_account.checkins.find(params[:id])
    @checkin.destroy

    respond_to do |format|
      format.html { redirect_to checkins_url }
      format.json { head :no_content }
    end
  end
end
