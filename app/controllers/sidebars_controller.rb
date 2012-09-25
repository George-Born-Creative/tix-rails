class SidebarsController < ApplicationController
  layout 'manager_cms'

  # GET /sidebars
  # GET /sidebars.json
  def index
    @sidebars = Sidebar.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sidebars }
    end
  end

  # GET /sidebars/1
  # GET /sidebars/1.json
  def show
    @sidebar = Sidebar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sidebar }
    end
  end

  # GET /sidebars/new
  # GET /sidebars/new.json
  def new
    @sidebar = Sidebar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sidebar }
    end
  end

  # GET /sidebars/1/edit
  def edit
    @sidebar = Sidebar.find(params[:id])
  end

  # POST /sidebars
  # POST /sidebars.json
  def create
    @sidebar = Sidebar.new(params[:sidebar])

    respond_to do |format|
      if @sidebar.save
        format.html { redirect_to @sidebar, notice: 'Sidebar was successfully created.' }
        format.json { render json: @sidebar, status: :created, location: @sidebar }
      else
        format.html { render action: "new" }
        format.json { render json: @sidebar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sidebars/1
  # PUT /sidebars/1.json
  def update
    @sidebar = Sidebar.find(params[:id])

    respond_to do |format|
      if @sidebar.update_attributes(params[:sidebar])
        # format.html { redirect_to @sidebar, notice: 'Sidebar was successfully updated.' }
        format.html { redirect_to edit_sidebar_path( @sidebar), notice: 'Sidebar was successfully updated.' }
        
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sidebar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sidebars/1
  # DELETE /sidebars/1.json
  def destroy
    @sidebar = Sidebar.find(params[:id])
    @sidebar.destroy

    respond_to do |format|
      format.html { redirect_to sidebars_url }
      format.json { head :no_content }
    end
  end
end
