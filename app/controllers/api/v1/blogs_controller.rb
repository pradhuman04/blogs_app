module Api
  module V1
    class BlogsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authorize_user

      def index
        blogs = current_user.blogs
        render json: blogs
      end

      def create
        blog = current_user.blogs.build(blog_params)
        if blog.save
          render json: blog, status: :created
        else
          render json: { error: blog.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def blog_params
        params.permit(:title, :content)
      end

      def authorize_user
        head :unauthorized unless current_user
      end
    end
  end
end
