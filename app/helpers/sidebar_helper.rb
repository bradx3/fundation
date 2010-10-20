module SidebarHelper
  # Returns a simple sidebar with name as the title, 
  # and any content from block as the links in a list
  def simple_sidebar(name = "Actions", list = nil, &block)
    list ||= capture_haml { block.call }
    render(:partial => "/common/sidebar", :locals => { :name => name, :list => list })
  end

  def deposit_template_sidebar
    templates = current_user.family.deposit_templates
    list = templates.map do |dt|
      link = link_to_function("Use #{ dt.name.titlecase }", "useDepositTemplate(#{ dt.id });")
      content_tag(:li, link)
    end
    simple_sidebar("Deposit Templates", list.join)
  end
end
