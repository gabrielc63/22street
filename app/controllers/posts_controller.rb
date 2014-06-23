class PostsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user,   only: :destroy

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "post created!"
      redirect_to root_url + "##{@post.id}"
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_url
  end


  private

    def post_params
      params.require(:post).permit(:to_friend_id, :content, :picture, :topic_id)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end

