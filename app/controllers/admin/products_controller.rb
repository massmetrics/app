module Admin
  class ProductsController < BaseController
    before_action :get_product_and_categories, only: [:edit, :update, :destroy]

    def index
      @products = Product.all
    end

    def new
    end

    def create
      if new_params_set?
        sku = params[:sku]
        categories = SubmissionHelper.split_categories(params[:category])
        ProductAdder.add_category([sku], categories)
        flash[:notice] = "Product successfully added"
        redirect_to admin_products_path
      else
        flash[:notice] = "Please set params"
        redirect_to :back
      end
    end

    def edit
      if @product.categories.count > 0
        @selection = @product.categories.first.id
      else
        @selection = 0
      end
    end

    def update
      category = Category.find(params[:category])
      ProductCategory.find_or_create_by(product: @product, category: category)
      redirect_to edit_admin_product_path(@product)
    end

    def destroy
      @product.destroy
      redirect_to admin_products_path
    end

    private
    def get_product_and_categories
      @product = Product.find(params[:id])
      @categories = ProductCategory.where(product_id: @product.id).includes(:category)
    end

    def new_params_set?
      !(params[:sku].strip.blank? || params[:category].strip.blank?)
    end
  end
end