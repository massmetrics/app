class SubmissionsController < ApplicationController
  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(allowed_params)
    if @submission.save
      flash[:success] = "Thank you for your submission, it will be reviewed shortly"
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def allowed_params
    params.require(:submission).permit(:sku, :category)
  end
end