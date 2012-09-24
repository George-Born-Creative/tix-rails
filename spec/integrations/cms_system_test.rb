require 'spec_helper'

describe 'CMS System Integration' do
  
  before :each do 
   Page.delete_all
   Widget.delete_all
   Sidebar.delete_all
   
   @page = Page.new(:slug => 'about', :title => 'Page 1', :body => 'some content' )
   
   @widget1 = Widget.new(:slug => 'widget-1', :body => 'some content', :title => 'Sidebar 1'  )
   @widget2 = Widget.new(:slug => 'widget-2', :body => 'some content', :title => 'Sidebar 1'  )
   @widget1.save
   @widget2.save
   
   @sidebar = Sidebar.new(:slug => 'sidebar-1', :title => 'Sidebar 1' )
   @sidebar.save
   
   @sidebar.widget_placements.create(:widget_id => @widget1.id, :index => 1)
   @sidebar.widget_placements.create(:widget_id => @widget2.id, :index => 2)  
   @sidebar.save
   
   @page.sidebar = @sidebar 
   @page.save
  end
  
  it 'page has one sidbear' do
    @page.sidebar.should eq @sidebar
  end
  
  it 'sidebar has two widgets' do
    @page.sidebar.widgets.count.should eq 2
  end
  
  it 'should give full stack of widget html in widget order'
  
end