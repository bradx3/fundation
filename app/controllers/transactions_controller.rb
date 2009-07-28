class TransactionsController < ApplicationController
  helper_method :filter_params

  # GET /transactions
  # GET /transactions.xml
  def index
    conds = filter_params
    @transactions = current_user.family.transactions.all(:conditions => conds,
                                                         :include => :fund_transactions,
                                                         :order => "transactions.id desc")
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
    flash[:notice] = "#{ @transaction.type } deleted"
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  end

  private
  
  # Returns all the filter params for the current request
  def filter_params
    res = params[:f] || {}
    res = res.delete_if { |column, values| values.nil? or values.empty? } 

    return res
  end
end
