module Admin
  class ProductsController < BaseController
    before_action :get_product_and_categories, only: [:edit, :update, :destroy]

    def index
      @products = Product.all
    end

    def new
      @product = Product.new
    end

    def create
      sku = params[:sku]
      categories = SubmissionHelper.split_categories(params[:category])
      ProductAdder.add([sku], categories)
      flash[:notice] = "Product successfully added"
      redirect_to :back
    end

    def edit
    end

    def update
      categories = SubmissionHelper.split_categories(params[:categories])
      @product.update_categories(categories)
      redirect_to edit_admin_product_path(@product)
    end

    def destroy
      @product.destroy
      redirect_to admin_products_path
    end

    private
    def get_product_and_categories
      @product = Product.find(params[:id])
      @categories = @product.categories.map(&:category).join(",")
    end
  end
end