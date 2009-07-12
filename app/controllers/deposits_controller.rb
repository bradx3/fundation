class DepositsController < ApplicationController
  # GET /deposits
  # GET /deposits.xml
  def index
    @deposits = Deposit.all(:order => "created_at desc")
    @total = @deposits.inject(0) { |total, dep| total += dep.dollars }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @deposits }
    end
  end

  # GET /deposits/1
  # GET /deposits/1.xml
  def show
    @deposit = Deposit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deposit }
    end
  end

  # GET /deposits/new
  # GET /deposits/new.xml
  def new
    @deposit = Deposit.new
    init_all_deposit_accounts

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deposit }
    end
  end

  # GET /deposits/1/edit
  def edit
    @deposit = Deposit.find(params[:id])
  end

  # POST /deposits
  # POST /deposits.xml
  def create
    @deposit = Deposit.new(params[:deposit])

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
    @deposit = Deposit.find(params[:id])

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

  # DELETE /deposits/1
  # DELETE /deposits/1.xml
  def destroy
    @deposit = Deposit.find(params[:id])
    @deposit.destroy

    respond_to do |format|
      format.html { redirect_to(deposits_url) }
      format.xml  { head :ok }
    end
  end

  def accounts
    @deposit_type = DepositType.find(params[:type_id])
    @deposit_type.init_all_account_percentages
    amount = params[:amount].to_i
    
    @result = {}
    @deposit_type.deposit_type_account_percentages.each do |dtap|
      values = {
        :percentage => dtap.percentage,
        :amount => (amount.to_f * (dtap.percentage / 100.0))
      }
      @result[dtap.account_id] = values
    end

    render :json => @result.to_json
  end


  private

  def init_all_deposit_accounts
    accounts = Account.all
    deposit_accounts = @deposit.deposit_accounts
    set_accounts = deposit_accounts.map { |d| d.account }

    (accounts - set_accounts).each do |acc|
      deposit_accounts.build(:percentage => 0, :account => acc)
    end
  end
end
