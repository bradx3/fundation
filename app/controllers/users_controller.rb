class UsersController < ApplicationController
  skip_filter :require_user, :only => [ :confirm, :confirm_password ]

  # GET /users
  # GET /users.xml
  def index
    @users = current_user.family.users

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /user/1
  # GET /user/1.xml
  def show
    @user = current_user.family.users.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /user/new
  # GET /user/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /user/1/edit
  def edit
    @user = current_user.family.users.find(params[:id])
  end

  # POST /user
  # POST /user.xml
  def create
    @user = User.new(params[:user])
    @user.login = @user.email
    @user.generate_random_password
    @user.family = current_user.family

    respond_to do |format|
      if @user.save
        Notifications.user_created(@user, current_user).deliver

        flash[:notice] = "User was successfully created. They will receive an email with their user details"
        format.html { redirect_to(users_path) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user/1
  # PUT /user/1.xml
  def update
    @user = current_user.family.users.find(params[:id])
    @user.family = current_user.family

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(users_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user/1
  # DELETE /user/1.xml
  def destroy
    @user = current_user.family.users.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def confirm
    @user = User.find_using_perishable_token(params[:token], 7.days.ago)

    if @user
      @user.update_attribute(:crypted_password, "")
      @user.login = ""
      UserSession.create(@user)
    else
      flash[:notice] = "Incorrect confirmation URL"
      logout
      redirect_to login_path
    end
  end

 def confirm_password
    @user = current_user
    
    if @user.update_attributes(params[:user])
      # may need to log them back in 
      if UserSession.find.nil?
        UserSession.create(@user)
      end
      
      flash[:notice] = "Signup confirmed. Thanks for joining #{ $SITE_NAME }."
      redirect_to "/"
    else
      render :action => :confirm
    end
  end
end
