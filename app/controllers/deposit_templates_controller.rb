class DepositTemplatesController < ApplicationController
  # GET /deposit_templates
  # GET /deposit_templates.xml
  def index
    @deposit_templates = DepositTemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @deposit_templates }
    end
  end

  # GET /deposit_templates/1
  # GET /deposit_templates/1.xml
  def show
    @deposit_template = DepositTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deposit_template }
    end
  end

  # GET /deposit_templates/new
  # GET /deposit_templates/new.xml
  def new
    @deposit_template = DepositTemplate.new
    @deposit_template.init_all_account_percentages

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deposit_template }
    end
  end

  # GET /deposit_templates/1/edit
  def edit
    @deposit_template = DepositTemplate.find(params[:id])
    @deposit_template.init_all_account_percentages
  end

  # POST /deposit_templates
  # POST /deposit_templates.xml
  def create
    @deposit_template = DepositTemplate.new(params[:deposit_template])

    respond_to do |format|
      if @deposit_template.save
        flash[:notice] = 'DepositTemplate was successfully created.'
        format.html { redirect_to(@deposit_template) }
        format.xml  { render :xml => @deposit_template, :status => :created, :location => @deposit_template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @deposit_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /deposit_templates/1
  # PUT /deposit_templates/1.xml
  def update
    @deposit_template = DepositTemplate.find(params[:id])

    respond_to do |format|
      if @deposit_template.update_attributes(params[:deposit_template])
        flash[:notice] = 'DepositTemplate was successfully updated.'
        format.html { redirect_to(@deposit_template) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deposit_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /deposit_templates/1
  # DELETE /deposit_templates/1.xml
  def destroy
    @deposit_template = DepositTemplate.find(params[:id])
    @deposit_template.destroy

    respond_to do |format|
      format.html { redirect_to(deposit_templates_url) }
      format.xml  { head :ok }
    end
  end

end
