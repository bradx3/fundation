class TransfersController < ApplicationController
  def new
  end

  def create
    from = current_user.family.funds.find(params[:from])
    to = current_user.family.funds.find(params[:to])
    amount = params[:amount].to_f

    if amount <= 0
      flash[:error] = "You have to transfer an amount greater than 0"
      render :new

    elsif from == to
      flash[:error] = "You can't transfer to the same account"
      render :new

    else
      w = Withdrawal.new(:user => current_user, :description => "Transfer")
      w.fund_transactions.build(:fund => from, :dollars => amount)
      if w.save!
        d = Deposit.new(:user => current_user, :dollars => amount, :description => "Transfer")
        d.fund_transactions.build(:fund => to, :dollars => amount)
        d.save!
      end

      flash[:notice] = "Money transferred"
      redirect_to transactions_path
    end
  end
end
