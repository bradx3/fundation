module SidebarHelper
  # Returns a simple sidebar with name as the title, 
  # and any content from block as the links in a list
  def simple_sidebar(name = "Actions", &block)
    list = capture_haml { block.call }
    render(:partial => "/common/sidebar", :locals => { :name => name, :list => list })
  end
end
