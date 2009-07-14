class TransactionsController < ApplicationController
  # GET /transactions
  # GET /transactions.xml
  def index
    @transactions = current_user.family.transactions(:order => "created_at desc")
    @total = @transactions.inject(0) { |total, t| total += t.dollars }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transactions }
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.xml
  def destroy
    @transaction = current_user.family.transactions.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  end
end
