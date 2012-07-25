class ArtistsController < ApplicationController
  respond_to :json

  def index
    @artists = Artist.all

    respond_with @artists
  end

  def show
    @artist = Artist.find(params[:id])

    respond_with @artist
  end
  
  def new
    @artist = Artist.new

    respond_with @artist
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def create
    @artist = Artist.new(params[:artist])

    respond_to do |format|
      if @artist.save
        format.json { render json: @artist, status: :created, location: @artist }
      else
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @artist = Artist.find(params[:id])

    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        format.html { redirect_to @artist, notice: 'Seating chart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to artists_url }
      format.json { head :no_content }
    end
  end
end
