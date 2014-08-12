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
        ProductAdder.add([sku], categories)
        flash[:notice] = "Product successfully added"
        redirect_to admin_products_path
      else
        flash[:notice] = "Please set params"
        redirect_to :back
      end
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
      @categories = @product.categories.map(&:category).sort.join(",")
    end

    def new_params_set?
      !(params[:sku].strip.blank? || params[:category].strip.blank?)
    end
  end
end