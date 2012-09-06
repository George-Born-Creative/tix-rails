class TicketTemplatesController < ApplicationController
  # GET /ticket_templates
  # GET /ticket_templates.json
  def index
    @ticket_templates = @current_account.ticket_templates.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ticket_templates }
    end
  end

  # GET /ticket_templates/1
  # GET /ticket_templates/1.json
  def show
    @ticket_template = @current_account.ticket_templates.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket_template }
    end
  end

  # GET /ticket_templates/new
  # GET /ticket_templates/new.json
  def new
    @ticket_template = @current_account.ticket_templates.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket_template }
    end
  end

  # GET /ticket_templates/1/edit
  def edit
    @ticket_template = @current_account.ticket_templates.find(params[:id])
  end

  # POST /ticket_templates
  # POST /ticket_templates.json
  def create
    @ticket_template = @current_account.ticket_templates.new(params[:ticket_template])

    respond_to do |format|
      if @ticket_template.save
        format.html { redirect_to @ticket_template, notice: 'Ticket template was successfully created.' }
        format.json { render json: @ticket_template, status: :created, location: @ticket_template }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ticket_templates/1
  # PUT /ticket_templates/1.json
  def update
    @ticket_template = TicketTemplate.find(params[:id])

    respond_to do |format|
      if @ticket_template.update_attributes(params[:ticket_template])
        format.html { redirect_to @ticket_template, notice: 'Ticket template was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_templates/1
  # DELETE /ticket_templates/1.json
  def destroy
    @ticket_template = @current_account.ticket_templates.find(params[:id])
    @ticket_template.destroy

    respond_to do |format|
      format.html { redirect_to ticket_templates_url }
      format.json { head :no_content }
    end
  end
end
