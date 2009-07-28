module SidebarHelper
  # Returns a simple sidebar with name as the title, 
  # and any content from block as the links in a list
  def simple_sidebar(name = "Actions", &block)
    content_for(:sidebar) do
      content_tag(:div, :class => "block") do
        res = content_tag(:h3, name)
        res += content_tag(:ul, :class => "navigation") do
          capture_haml { yield }
        end
        res
      end
    end
  end
end
