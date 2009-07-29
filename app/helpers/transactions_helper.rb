module TransactionsHelper

  # Returns a list of check boxes and labels for use in filtering
  def check_box_filters_for(column, objects)
    res = ""
    objects.each do |o|
      res += check_box_filter_for(column, o)
    end
    
    return res
  end
  
  # Returns all the filter params for the current request
  def filter_params
    params[:f] || {}
  end

  # Returns true if a filter checkbox for the given object should
  # be checked.
  def filter_checked?(column, object)
    fp = filter_params[column]
    return (fp.nil? or fp.empty? or fp.include?(object.id.to_s))
  end
  
  # Returns a check box and label for use in filtering
  def check_box_filter_for(column, object)
    content_tag :li do
      name = "f[#{ column }][]"
      id = "f_#{ column }_#{ object.id }"

      res = check_box_tag(name, object.id, filter_checked?(column, object), 
                          :id => id, :class => "checkbox")
      res += label_tag(id, object.to_s, :class => "checkbox")

      res
    end
  end

  # Returns a before and after field for filtering by date
  def date_filter_for(field)
    res = ""
    res += content_tag(:li) do
      name = "f[created_after]"
      id = "f_created_after"
      res = label_tag(id, "After", :class => "label")
      res += calendar_date_select_tag(name, filter_params[:created_after], :id => id)
    end
    res += content_tag(:li) do
      name = "f[created_before]"
      id = "f_created_before"
      res = label_tag(id, "Before", :class => "label")
      res += calendar_date_select_tag(name, filter_params[:created_before], :id => id)
    end

    return res
  end

end
