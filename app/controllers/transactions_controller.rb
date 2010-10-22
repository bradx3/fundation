class TransactionsController < ApplicationController
  helper_method :filter_params

  # GET /transactions
  # GET /transactions.xml
  def index
    @transactions = current_user.family.transactions.all(:conditions => search_conditions,
                                                         :include => [ :user, :fund_transactions ],
                                                         :order => "transactions.id desc")
    @transactions = Transaction.trim_filtered_funds(@transactions, filter_params["fund_transactions.fund_id"])
    @total = @transactions.inject(0) { |total, t| total += t.allocated_dollars }

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

  def search_conditions
    params = filter_params
    string = []
    cond_params = []

    if created_after = params.delete(:created_after)
      string << "transactions.created_at >= ?"
      cond_params << Date.strptime(created_after, "%Y-%m-%d")
    end
    if created_before = params.delete(:created_before)
      string << "transactions.created_at <= ?"
      cond_params << Date.strptime(created_before, "%Y-%m-%d")
    end

    if params[:user_id] and params[:user_id].any?
      string << "transactions.user_id in (?)"
      cond_params << params[:user_id]
    end

    if params[:fund_id] and params[:fund_id].any?
      string << "fund_transactions.fund_id in (?)"
      cond_params << params[:fund_id]
    end

    string = string.join(" and ")
    return [ string ] + cond_params
  end
  
  # Returns all the filter params for the current request
  def filter_params
    res = (params[:f] || {}).dup
    res = res.delete_if { |column, values| values.nil? or values.empty? } 

    return res
  end

end
