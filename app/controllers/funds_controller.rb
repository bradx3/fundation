class FundsController < ApplicationController
  # GET /funds
  # GET /funds.xml
  def index
    @funds = current_user.family.funds.active

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @funds }
    end
  end

  # GET /funds/1
  # GET /funds/1.xml
  def show
    @fund = current_user.family.funds.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fund }
    end
  end

  # GET /funds/new
  # GET /funds/new.xml
  def new
    @fund = Fund.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fund }
    end
  end

  # GET /funds/1/edit
  def edit
    @fund = current_user.family.funds.find(params[:id])
  end

  # POST /funds
  # POST /funds.xml
  def create
    @fund = Fund.new(params[:fund])
    @fund.user = current_user

    respond_to do |format|
      if @fund.save
        @fund.unset_any_other_default_sync_funds
        flash[:notice] = 'Fund was successfully created.'
        format.html { redirect_to(@fund) }
        format.xml  { render :xml => @fund, :status => :created, :location => @fund }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fund.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /funds/1
  # PUT /funds/1.xml
  def update
    @fund = current_user.family.funds.find(params[:id], :readonly => false)

    respond_to do |format|
      if @fund.update_attributes(params[:fund])
        @fund.unset_any_other_default_sync_funds
        flash[:notice] = 'Fund was successfully updated.'
        format.html { redirect_to(@fund) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fund.errors, :status => :unprocessable_entity }
      end
    end
  end

  def archive
    @fund = current_user.family.funds.find(params[:id], :readonly => false)
    if @fund.update_attributes(:archived => true)
      flash[:notice] = 'Fund deleted.'
      redirect_to "/"
    else
      render :action => "edit"
    end
  end
end
