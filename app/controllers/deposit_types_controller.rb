class DepositTypesController < ApplicationController
  # GET /deposit_types
  # GET /deposit_types.xml
  def index
    @deposit_types = DepositType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @deposit_types }
    end
  end

  # GET /deposit_types/1
  # GET /deposit_types/1.xml
  def show
    @deposit_type = DepositType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deposit_type }
    end
  end

  # GET /deposit_types/new
  # GET /deposit_types/new.xml
  def new
    @deposit_type = DepositType.new
    init_all_account_percentages

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deposit_type }
    end
  end

  # GET /deposit_types/1/edit
  def edit
    @deposit_type = DepositType.find(params[:id])
    init_all_account_percentages
  end

  # POST /deposit_types
  # POST /deposit_types.xml
  def create
    @deposit_type = DepositType.new(params[:deposit_type])

    respond_to do |format|
      if @deposit_type.save
        flash[:notice] = 'DepositType was successfully created.'
        format.html { redirect_to(@deposit_type) }
        format.xml  { render :xml => @deposit_type, :status => :created, :location => @deposit_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @deposit_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /deposit_types/1
  # PUT /deposit_types/1.xml
  def update
    @deposit_type = DepositType.find(params[:id])

    respond_to do |format|
      if @deposit_type.update_attributes(params[:deposit_type])
        flash[:notice] = 'DepositType was successfully updated.'
        format.html { redirect_to(@deposit_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deposit_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /deposit_types/1
  # DELETE /deposit_types/1.xml
  def destroy
    @deposit_type = DepositType.find(params[:id])
    @deposit_type.destroy

    respond_to do |format|
      format.html { redirect_to(deposit_types_url) }
      format.xml  { head :ok }
    end
  end

  private

  def init_all_account_percentages
    accounts = Account.all
    percentages = @deposit_type.deposit_type_account_percentages
    set_accounts = percentages.map { |d| d.account }

    (accounts - set_accounts).each do |acc|
      percentages.build(:percentage => 0, :account => acc)
    end
  end
end
