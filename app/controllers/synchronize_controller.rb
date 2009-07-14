class SynchronizeController < ApplicationController
  def new
  end

  def create
    local_balance = current_user.family.total_balance
    actual_balance = params[:actual_balance].to_f

    difference = actual_balance - local_balance
    if difference >= 0
      flash[:notice] = "You can't synchronize to a greater balance. Just use a deposit"
      redirect_to new_deposit_path
    else
      @withdrawal = Withdrawal.new(:dollars => difference)
      @withdrawal.init_all_deposit_funds

      default = @withdrawal.fund_transactions.detect { |at| at.fund.default_synchronize_fund? }
      default.dollars = difference.abs if default

      render :template => "/withdrawals/new"
    end
    
  end
end
