class ChartsController < ApplicationController
  respond_to :json, :html
  # GET /charts
  # GET /charts.json
  def index
    @charts = @current_account.charts.all
    @chart = @current_account.charts.first
    respond_with @charts
  end

  # GET /charts/1
  # GET /charts/1.json
  def show
    @chart = @current_account.charts.find(params[:id])

    respond_with @chart
  end

  # GET /charts/new
  # GET /charts/new.json
  def new
    @chart = @current_account.charts.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chart }
    end
  end

  # GET /charts/1/edit
  def edit
    @chart = @current_account.charts.find(params[:id])
  end

  # POST /charts
  # POST /charts.json
  def create
    @chart = @current_account.charts.new(params[:chart])

    respond_to do |format|
      if @chart.save
        format.html { redirect_to @chart, notice: 'Seating chart was successfully created.' }
        format.json { render json: @chart, status: :created, location: @chart }
      else
        format.html { render action: "new" }
        format.json { render json: @chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /charts/1
  # PUT /charts/1.json
  def update
    @chart = @current_account.charts.find(params[:id])

    respond_to do |format|
      if @chart.update_attributes(params[:chart])
        format.html { redirect_to @chart, notice: 'Seating chart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charts/1
  # DELETE /charts/1.json
  def destroy
    @chart = @current_account.charts.find(params[:id])
    @chart.destroy

    respond_to do |format|
      format.html { redirect_to charts_url }
      format.json { head :no_content }
    end
  end
end
