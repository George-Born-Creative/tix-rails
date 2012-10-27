class CarouselItemsController < InheritedResources::Base  
  layout 'manager_cms'
  
  
  before_filter :set_carousel, :only => [:index, :new, :create, :update, :edit, :destroy]
  
  def index
    @carousel_items = @carousel.carousel_items
  end

  def new
    @carousel_item = @carousel.carousel_items.new
    @carousel_item.build_image unless @carousel_item.image
    
  end
  
  def edit
    @carousel_item = @carousel.carousel_items.find(params[:id])
    @carousel_item.build_image unless @carousel_item.image
  end
  
  def create
    @carousel_item = @carousel.carousel_items.build(params[:carousel_item])  
    if @carousel_item.save  
      flash[:notice] = "Successfully created carousel item."  
      redirect_to carousel_path(@carousel)  
    else  
      render :action => 'new'  
    end
  end
  
  def update
    @carousel_item = @carousel.carousel_items.find(params[:id])  
    if @carousel_item.update_attributes(params[:carousel_item])
      flash[:notice] = "Successfully updated carousel item."  
      redirect_to carousel_path(@carousel)  
    else  
      render :action => 'edit'
    end
  end
  
  def destroy
    @carousel_item = @carousel.carousel_items.find(params[:id]) 
    @carousel_item.destroy
    
    respond_to do |format|
      format.html { redirect_to carousel_url(@carousel) }
      format.json { head :no_content }
    end

  end
  
  private
  
  def set_carousel
    @carousel = Carousel.find(params[:carousel_id])
  end
  
  
end
