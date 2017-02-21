class Admin::CategoriesController < ApplicationController
  before_action :verify_admin
  before_action :find_category, except: [:index, :new, :create]
  before_action :load_category, only: [:index, :show]

  def index
  end
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "flash.success_category"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def show
    @book = @category.books.build
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "flash.update_category"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "flash.destroy_category_success"
    else
      flash[:danger] = t "flash.destroy_category_error"
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end

  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:warning] = t "flash.error_find_catagory"
      redirect_to admin_categories_path	
    end
  end

  def load_category
    @categories = Category.all
  end
end
