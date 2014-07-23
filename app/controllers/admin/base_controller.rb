module Admin
  class BaseController < ApplicationController
    before_filter :verify_admin

    def index

    end

    private
    def verify_admin
      redirect_to root_path, notice: "You don't have permission to access that page" unless logged_in? && current_user.role?(:admin)
    end
  end
end