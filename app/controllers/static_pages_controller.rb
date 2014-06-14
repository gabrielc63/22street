class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @user = User.find(current_user.id)
      @single_post = @user.posts.build
      @reply = @user.posts.build
      # @posts = @user.posts if @user.posts != nil
      # @responses = @user.posts_received if @user.posts_received != nil
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def contact
  end
end
