class SeatingChartsController < ApplicationController
  respond_to :json
  # GET /seating_charts
  # GET /seating_charts.json
  def index
    @seating_charts = @current_account.seating_charts.all

    respond_with @seating_charts
  end

  # GET /seating_charts/1
  # GET /seating_charts/1.json
  def show
    @seating_chart = @current_account.seating_charts.find(params[:id])

    respond_with @seating_chart
  end

  # GET /seating_charts/new
  # GET /seating_charts/new.json
  def new
    @seating_chart = @current_account.seating_charts.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @seating_chart }
    end
  end

  # GET /seating_charts/1/edit
  def edit
    @seating_chart = @current_account.seating_charts.find(params[:id])
  end

  # POST /seating_charts
  # POST /seating_charts.json
  def create
    @seating_chart = @current_account.seating_charts.new(params[:seating_chart])

    respond_to do |format|
      if @seating_chart.save
        format.html { redirect_to @seating_chart, notice: 'Seating chart was successfully created.' }
        format.json { render json: @seating_chart, status: :created, location: @seating_chart }
      else
        format.html { render action: "new" }
        format.json { render json: @seating_chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /seating_charts/1
  # PUT /seating_charts/1.json
  def update
    @seating_chart = @current_account.seating_charts.find(params[:id])

    respond_to do |format|
      if @seating_chart.update_attributes(params[:seating_chart])
        format.html { redirect_to @seating_chart, notice: 'Seating chart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @seating_chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seating_charts/1
  # DELETE /seating_charts/1.json
  def destroy
    @seating_chart = @current_account.seating_charts.find(params[:id])
    @seating_chart.destroy

    respond_to do |format|
      format.html { redirect_to seating_charts_url }
      format.json { head :no_content }
    end
  end
end
