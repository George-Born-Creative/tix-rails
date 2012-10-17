class SidebarsController < InheritedResources::Base
  layout 'manager_cms'
  
  def update
    update! {edit_sidebar_path(@sidebar)}
  end
  
  def sort
    @sidebar = @current_account.sidebars.find(params[:id])
    
    unless params[:widget].blank?
      @sidebar.widget_placements.delete_all
      params[:widget].each_with_index do |widget_id, index|
        @sidebar.widget_placements.create(:widget_id => widget_id, :index => index)
      end
    end
    
    respond_to do |format|
      if @sidebar.save
        format.js {render :text => 'Success' }
      else
        # TODO: Handle error properly on server and on client
        format.js {render :text => 'Fail' }
      end
    end
  end
  
  
  
  protected
  
  # def collection
  #   @sidebars ||= end_of_association_chain.order('created_at ASC')
  # end
  
  def begin_of_association_chain
    @current_account
  end
  
  
end
