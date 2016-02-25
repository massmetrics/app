module Admin
  class SubmissionsController < BaseController
    before_action :find_submission, only: [:edit, :destroy]
    def index
      @submissions = Submission.all
    end

    def edit
      @amazon_detail_page = "http://www.amazon.com/gp/product/#{@submission.sku}/"
    end

    def update
      categories = SubmissionHelper.split_categories(params[:submission][:category])
      sku = params[:submission][:sku]
      Product.create_multiple([sku])
      ProductAdder.add_category([sku], categories)
      submission = Submission.find_by(sku: sku)
      submission.destroy
      redirect_to admin_submissions_path
    end

    def destroy
      @submission.destroy
      redirect_to admin_submissions_path
    end

    private
    def find_submission
      @submission = Submission.find(params[:id])
    end
  end
end