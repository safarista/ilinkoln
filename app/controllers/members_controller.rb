class MembersController < ApplicationController
  # before_filter :authorize, :except => [:index, :show]
  before_filter :can_modify, :only => [:edit, :update, :destroy] 
  respond_to :html, :xml, :json 
  # GET /members
  # GET /members.xml
  def index
    @members = Member.all(:order => "created_at DESC")
    @title = "This is a list of all members"
    respond_with (@members)
  end

  # GET /members/1
  # GET /members/1.xml
  def show
    @member = Member.find(params[:id])
    @title = "#{@member.name}"
  
    respond_with(@member)
  end
 
  # GET /members/new
  # GET /members/new.xml
  def new
    @member = Member.new
    @title = "Add a new person"

    respond_with(@member)
  end

  # GET /members/1/edit
  def edit
    @title = "Editing #{@member.name}'s details"
        
    
  end

  # # POST /members
  # # POST /members.xml
  # def create
  #   @member = Member.new(params[:member])
  # 
  #   respond_to do |format|
  #     if @member.save
  #       format.html { redirect_to(@member, :notice => 'member was successfully created.') }
  #       format.xml  { render :xml => @member, :status => :created, :location => @member }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # PUT /members/1
  # PUT /members/1.xml
  def update
    
      if @member.update_attributes(params[:member])
        redirect_to(members_path, :notice => 'Member was successfully updated.')
      else
         render :action => "edit"
      end
  end

  # DELETE /members/1
  # DELETE /members/1.xml
  def destroy
    @member.destroy

    respond_with(@member) { redirect_to(members_url, :notice => 'Member was successfully deleted.') }
    
  end
  
  protected
  def can_modify
    @member = Member.find(params[:id])
    @member = current_member if !admin? 
  end
end
