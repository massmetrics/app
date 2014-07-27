class SubmissionsController < ApplicationController
  def new
    meta_tag_setter(
      "Suggest product",
      'Best discounts for health and beauty products',
      key_words,
      false
    )
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(allowed_params)
    if @submission.save
      flash[:notice] = "Thank you for your submission, it will be reviewed shortly"
      redirect_to new_submission_path
    else
      render :new
    end
  end

  private
  def allowed_params
    params.require(:submission).permit(:sku, :category)
  end
end