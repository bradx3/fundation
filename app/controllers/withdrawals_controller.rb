class WithdrawalsController < ApplicationController
  # GET /withdrawals/new
  # GET /withdrawals/new.xml
  def new
    @withdrawal = Withdrawal.new
    @withdrawal.init_all_deposit_accounts

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @withdrawal }
    end
  end

  # POST /withdrawals
  # POST /withdrawals.xml
  def create
    @withdrawal = Withdrawal.new(params[:withdrawal])
    @withdrawal.user = current_user
    @withdrawal.account_transactions.each { |da| da.dollars = (0 - da.dollars) }

    respond_to do |format|
      if @withdrawal.save
        flash[:notice] = 'Withdrawal was successfully created.'
        format.html { redirect_to(@withdrawal) }
        format.xml  { render :xml => @withdrawal, :status => :created, :location => @withdrawal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @withdrawal.errors, :status => :unprocessable_entity }
      end
    end
  end

end
