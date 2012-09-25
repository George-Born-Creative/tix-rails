class ImagesController < ApplicationController
  respond_to :json, :html
  layout 'manager_cms'
  
  # GET /images
  # GET /images.json
  def index
    @images = @current_account.images.all
    respond_with @images
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @image = @current_account.images.find(params[:id])

    respond_with @image
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @image = @current_account.images.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = @current_account.images.find(params[:id])
  end

  # POST /images
  # POST /images.json
  def create
    @image = @current_account.images.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.json
  def update
    @image = @current_account.images.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = @current_account.images.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url }
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
