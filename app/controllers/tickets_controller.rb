class TicketsController < ApplicationController
  respond_to :json, :html

  def index
    @tickets = Ticket.limit(50)

    respond_with @tickets
  end

  def show
    @ticket = Ticket.find(params[:id])

    respond_with @ticket
  end
  
  def new
    @ticket = Ticket.new

    respond_with @ticket
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def create
    @ticket = Ticket.new(params[:ticket])

    respond_to do |format|
      if @ticket.save
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to @ticket, notice: 'Seating chart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end
end
