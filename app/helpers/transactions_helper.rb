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
      fields_for(field) do |f|
        f.label(:after, nil, :class => "label") +
        f.text_field(:after, :class => "text_field")
      end
    end
    res += content_tag(:li) do
      fields_for(field) do |f|
        f.label(:before, nil, :class => "label") +
        f.text_field(:before, :class => "text_field")
      end
    end

    return res
  end

end
