module RegistrationHelper
  def deposit_template_rego_form(&block)
    form_for(@deposit_template, 
             :url => { :action => "setup_default_deposit_template" }, 
             :method => :post, 
             :html => { :id => "deposit_template", :class => "form login"}) do |f|
      yield(f)
    end
  end
end
