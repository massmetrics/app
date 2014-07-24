module Admin
  class ProductsController < BaseController
    before_action :get_product_and_categories, only: [:edit, :update]
    def index
      @products = Product.all
    end

    def edit
    end

    def update
      categories = SubmissionHelper.split_categories(params[:categories])
      @product.add_categories(categories)
      redirect_to edit_admin_product_path(@product)
    end

    private
    def get_product_and_categories
      @product = Product.find(params[:id])
      @categories = @product.categories.map(&:category).join(",")
    end
  end
end