class RegistrationController < ApplicationController
  layout "full_page"

  skip_before_filter :require_user, :only => [ :index, :create ]

  def index
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.build_family

    if @user.save
      @user_session = UserSession.new(params[:user])
      @user_session.save

      redirect_to :action => "step2"
    else
      render :action => "index"
    end
  end

  def step2
    if current_user.funds.empty?
      current_user.funds.build(:name => "Expenses")
      current_user.funds.build(:name => "Holiday Fund")
      current_user.funds.build(:name => "Car Fund")

      7.times { current_user.funds.build }
    end
  end

  def setup_funds
    current_user.attributes = params[:user]
    current_user.save!

    redirect_to :action => "step3"
  end

  def step3
    @deposit_template = current_user.deposit_templates.build(:name => "Default")
    @deposit_template.init_all_fund_percentages
  end

  def setup_default_deposit_template
    @deposit_template = current_user.deposit_templates.build(params[:deposit_template])
    @deposit_template.default = true

    if @deposit_template.save
      redirect_to :action => "complete"    
    else
      render :action => "step3"
    end
  end

  def complete
  end
end



