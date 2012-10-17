class WidgetsController < InheritedResources::Base
  # GET /widgets
  # GET /widgets.json
  layout 'manager_cms'

  
  # GET /widgets/1/edit
  def edit
    @sidebars = @current_account.sidebars
    @widget = @current_account.widgets.find(params[:id])
    super
  end
  
  
  protected
  
  # def collection
  #   @widget ||= end_of_association_chain.order('created_at ASC')
  # end
  
  def begin_of_association_chain
    @current_account
  end

end
