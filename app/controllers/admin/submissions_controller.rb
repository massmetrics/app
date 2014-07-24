module Admin
  class SubmissionsController < BaseController

    def index
      @submissions = Submission.all
    end

    def edit
      @submission = Submission.find(params[:id])
      @amazon_detail_page = "http://www.amazon.com/gp/product/#{@submission.sku}/"
    end

    def update
      categories = SubmissionHelper.split_categories(params[:submission][:category])
      sku = params[:submission][:sku]
      ProductAdder.add([sku], categories)
      redirect_to admin_submissions_path
    end

    private
    def allowed_params
      params.require(:submission).permit(:sku, :category)
    end
  end
end