# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_post

      def create
        comment = Comment.create(comment_params)
        if comment.save
          render json: CommentSerializer.new(comment).as_json, status: :created
        else
          render json: { error: comment.errors.full_messages.first }, status: :unprocessable_entity
        end
      end

      private

      def post_id
        params.require(:post_id)
      end

      def set_post
        @post = Post.find_by_id(post_id)
        render json: { error: 'post not found' }, status: :unprocessable_entity if @post.nil?
      end

      def comment_params
        params.require(:comment).permit(:description).merge(user_id: current_user.id, post_id: @post.id)
      end
    end
  end
end
