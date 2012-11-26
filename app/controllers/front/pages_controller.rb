class Front::PagesController < ApplicationController
  # cache_sweeper :page_sweeper
  
  #caches_action :show, :expires_in => 1.hour#, :cache_path => { :page => params[:slug] }
  
  # GET /pages
  # GET /pages.json
  def index
    @page = @current_account.pages.find_by_slug('home')
    respond_to do |format|
      format.html { render(:layout => 'sidebar_right', :action => :show) } # show.html.erb
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show

    slug = params[:slug] || 'home'
    @page = @current_account.pages.find_by_slug(slug)
    
    respond_to do |format|
      unless @page.nil?
        format.html { render :layout => 'sidebar_right' } # show.html.erb
        format.json { render json: @page }
      else
        format.html { not_found }# 404 }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = @current_account.pages.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = @current_account.pages.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = @current_account.pages.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = @current_account.pages.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = @current_account.pages.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end
end
