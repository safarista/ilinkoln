class CategoriesController < ApplicationController
  #before_filter :authorize, :except => [:index, :show]
  respond_to :html, :xml, :json
  
  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.all
    @title = "you are looking at a list of all categories"
    respond_with (@categories)
    
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])
    @title = @category.name
    respond_with (@category)
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = Category.new
    @title = "Create a new Category"
    respond_with (@category)
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
    @title = "Edit this Category"
  end

  # Category /categories
  # Category /categories.xml
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(@category, :notice => 'Category was successfully created.') }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(@category, :notice => 'Category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
end
