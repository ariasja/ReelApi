class Api::V1::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end
end
