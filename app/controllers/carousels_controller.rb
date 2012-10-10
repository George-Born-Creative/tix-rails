class CarouselsController < ApplicationController
  respond_to :json, :html
  layout 'manager_cms'
  
  # GET /carousels
  # GET /carousels.json
  def index
    @carousels = @current_account.carousels.all
    respond_with @carousels
  end

  # GET /carousels/1
  # GET /carousels/1.json
  def show
    redirect_to 'edit'
    #@carousel = @current_account.carousels.find(params[:id])
    #respond_with @carousel
  end

  # GET /carousels/new
  # GET /carousels/new.json
  def new
    @carousel = @current_account.carousels.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @carousel }
    end
  end

  # GET /carousels/1/edit
  def edit
    @carousel = @current_account.carousels.find(params[:id])
  end

  # POST /carousels
  # POST /carousels.json
  def create
    @carousel = @current_account.carousels.new(params[:carousel])

    respond_to do |format|
      if @carousel.save
        format.html { redirect_to @carousel, notice: 'Carousel was successfully created.' }
        format.json { render json: @carousel, status: :created, location: @carousel }
      else
        format.html { render action: "new" }
        format.json { render json: @carousel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carousels/1
  # PUT /carousels/1.json
  def update
    @carousel = @current_account.carousels.find(params[:id])

    respond_to do |format|
      if @carousel.update_attributes(params[:carousel])
        format.html { redirect_to @carousel, notice: 'Carousel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @carousel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carousels/1
  # DELETE /carousels/1.json
  def destroy
    @carousel = @current_account.carousels.find(params[:id])
    @carousel.destroy

    respond_to do |format|
      format.html { redirect_to carousels_url }
      format.json { head :no_content }
    end
  end
  
  # def tags
  #   @tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?", "%#{params[:q]}%") 
  #   respond_to do |format|
  #     format.json { render :json => @tags.collect{|t| {:id => t.name, :name => t.name }}}
  #   end
  # end
  require 'ostruct'
  
  def tags
    
    query = params[:q]
    #Do the search in memory for better performance
    # TODO Scope Account
    @tags = ActsAsTaggableOn::Tag.all
    @tags = @tags.select { |v| v.name =~ /#{query}/i }
    
    if @tags.length == 0
      @tags = [OpenStruct.new(:name => query, :id => query)]
    end
      
    respond_to do |format|
      format.json{ render :json => @tags.collect{|t| {:id => t.name, :name => "New: \"#{t.name}\"" }}  }
    end
  end
  
end
