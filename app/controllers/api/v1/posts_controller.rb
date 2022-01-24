# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController

      def create
        post = Post.create(post_params)
        if post.save
          render json: PostSerializer.new(post).as_json, status: :created
        else
          render json: { error: post.errors.full_messages.first }, status: :unprocessable_entity
        end
      end

      private

      def post_params
        params.require(:post).permit(:title, :content).merge(user_id: current_user.id)
      end
    end
  end
end
