class ThemesController < InheritedResources::Base
  respond_to :html, :except => :show
  
  layout 'manager_cms'
  before_filter :set_active_theme
  
  def create
    create! { edit_theme_url(@theme) }
  end
  
  def update
    update! { edit_theme_url(@theme) }
  end
  
  def activate
    @theme = Theme.find(params[:id])
    if @theme.activate!
      redirect_to themes_path, :notice => 'Theme has been activated'
    else
      redirect_to themes_path, :notice => 'Error: theme not activated'
    end
  end
  
  
  protected
  
  def collection
    @themes ||= end_of_association_chain.order('created_at ASC')
  end
  
  def begin_of_association_chain
    @current_account
  end
  
  private
  
  def set_active_theme
    @active_theme = @current_account.themes.active_theme
  end
  
end
