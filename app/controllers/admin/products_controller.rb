class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  layout "admin"

  def index
    if params[:category].blank?
	   @products=Product.all
    else
	     @category_id = Category.find_by(name: params[:category]).id
	    @products= Product.where(:category_id => @category_id).order(“created_at DESC”)
    end
  end

  def new
    @product=Product.new
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def show
    @product=Product.find(params[:id])
  end

  def edit
    @product=Product.find(params[:id])
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @product=Product.new(product_params)
    @product.category_id = params[:category_id]
     if @product.save
       redirect_to admin_products_path
     else
       render :new
     end
  end

  def update
    @product=Product.find(params[:id])
    @product.category_id = params[:category_id]
      if @product.update(product_params)
        redirect_to admin_products_path
      else
        render :edit
      end
  end

  def destroy
    @product=Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image, :categories, :category_id, :datetime, :location)
  end
end
