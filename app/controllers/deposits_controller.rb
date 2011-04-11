class DepositsController < ApplicationController

  # GET /deposits/1
  # GET /deposits/1.xml
  def show
    @deposit = current_user.family.transactions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deposit }
    end
  end

  # GET /deposits/new
  # GET /deposits/new.xml
  def new
    @deposit = Deposit.new(:user => current_user)
    @deposit.init_all_deposit_funds

    default = current_user.family.default_deposit_template
    default.apply(@deposit) if default

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deposit }
    end
  end

  # GET /deposits/1/edit
  def edit
    @deposit = current_user.family.transactions.find(params[:id])
  end

  # POST /deposits
  # POST /deposits.xml
  def create
    @deposit = Deposit.new(params[:deposit])
    @deposit.user = current_user

    respond_to do |format|
      if @deposit.save
        flash[:notice] = 'Deposit was successfully created.'
        format.html { redirect_to(@deposit) }
        format.xml  { render :xml => @deposit, :status => :created, :location => @deposit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @deposit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /deposits/1
  # PUT /deposits/1.xml
  def update
    @deposit = current_user.family.transactions.find(params[:id], :readonly => false)
    @deposit.user = current_user

    respond_to do |format|
      if @deposit.update_attributes(params[:deposit])
        flash[:notice] = 'Deposit was successfully updated.'
        format.html { redirect_to(@deposit) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deposit.errors, :status => :unprocessable_entity }
      end
    end
  end

  def funds
    @deposit_template = current_user.family.deposit_templates.find(params[:type_id])
    @deposit_template.init_all_fund_percentages
    amount = params[:amount].to_i
    
    @result = {}
    @deposit_template.deposit_template_fund_percentages.each do |dtap|
      values = {
        :percentage => dtap.percentage,
        :amount => (amount.to_f * (dtap.percentage / 100.0))
      }
      @result[dtap.fund_id] = values
    end

    render :json => @result.to_json
  end

end
