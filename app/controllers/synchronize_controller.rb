class SynchronizeController < ApplicationController
  def new
  end

  def start
    local_balance = current_user.family.total_balance
    actual_balance = params[:actual_balance].to_f

    difference = actual_balance - local_balance
    if difference >= 0
      flash[:notice] = "You can't synchronize to a greater balance. Just use a deposit"
      redirect_to new_deposit_path
    else
      @withdrawal = Withdrawal.new(:dollars => difference, 
                                   :user => current_user,
                                   :description => Withdrawal::SYNCHRONIZE)
      @withdrawal.init_all_deposit_funds

      default = @withdrawal.fund_transactions.detect { |at| at.fund.default_synchronize_fund? }
      default.dollars = difference.abs if default
    end
  end

  def create
    @withdrawal = Withdrawal.new(params[:withdrawal])
    @withdrawal.user = current_user
    
    respond_to do |format|
      if @withdrawal.save
        flash[:notice] = "Synchronize complete"
        format.html { redirect_to(@withdrawal) }
        format.xml  { render :xml => @withdrawal, :status => :created, :location => @withdrawal }
      else
        format.html { render :action => "start" }
        format.xml  { render :xml => @withdrawal.errors, :status => :unprocessable_entity }
      end
    end
  end
end
