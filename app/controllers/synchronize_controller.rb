class SynchronizeController < ApplicationController
  def new
  end

  def start
    local_balance = current_user.family.total_balance
    actual_balance = params[:actual_balance].to_f

    difference = actual_balance - local_balance
    type = difference < 0 ? Withdrawal : Deposit
    @transaction = type.new(:dollars => difference,
                            :user => current_user,
                            :description => Transaction::SYNCHRONIZE)
    @transaction.description = Transaction::SYNCHRONIZE
    @transaction.init_all_deposit_funds

    default = @transaction.fund_transactions.detect { |at| at.fund.default_synchronize_fund? }
    default.dollars = difference.abs if default
  end

  def create
    type = params[:type].constantize
    @transaction = type.new(params[type.name.underscore])
    @transaction.user = current_user
    
    respond_to do |format|
      if @transaction.save
        flash[:notice] = "Synchronize complete"
        format.html { redirect_to(@transaction) }
        format.xml  { render :xml => @transaction, :status => :created, :location => @transaction }
      else
        format.html { render :action => "start" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end
end
