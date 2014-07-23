module Admin
  class SubmissionsController < BaseController

    def index
      @submissions = Submission.all
    end
  end
end