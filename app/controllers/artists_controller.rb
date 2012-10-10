class ArtistsController < ApplicationController
  respond_to :json, :html

  def index
    respond_to do |format|
      format.json {
        render json: ArtistDatatable.new(view_context, @current_account.id)
      }
      format.html {
        @artists = @current_account.artists.where{ (name =~ my{"%#{params[:search]}%"} )}
                      .page(params[:page])
                      .per(10)
      }
    end
    
    # respond_with @artists
  end


  def show
    @artist = @current_account.artists.find(params[:id])

    respond_with @artist
  end
  
  def new
    @artist = @current_account.artists.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @artist }
    end
  end

  def edit
    @artist = @current_account.artists.find(params[:id])
  end

  def create
    @artist = @current_account.artists.new(params[:artist])
    
    respond_to do |format|
      if @artist.save
        format.html { redirect_to edit_artist_path(@artist), notice: 'Artist was successfully created.' }
        format.json { render json: @artist, status: :created, location: @artist }
      else
        format.html { render action: "show" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @artist = @current_account.artists.find(params[:id])

    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        format.html { redirect_to edit_artist_path(@artist), notice: 'Artist was successfully created.' }
        format.json { render json: @artist, status: :created, location: @artist }
      else
        format.html { render action: "show" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist = @current_account.artists.find(params[:id])
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to artists_url }
      format.json { head :no_content }
    end
  end
  
  
  
  def search
    # Do the search in memory for better performance
    @artists = @current_account.artists.where("name like :q", q: "%#{params[:q]}%").limit(10)

    respond_to do |format|
      format.json{ render :json => @artists.collect{|a| {:id => a.id, :name => a.name }}  }
    end
  end
end
