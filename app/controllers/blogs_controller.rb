class BlogsController < ApplicationController
  before_action :require_login

  def index
    @blogs = current_user.blogs
  end

  private

  def require_login
    unless current_user
      redirect_to login_path, alert: 'You must be logged in to access this section'
    end
  end
end
