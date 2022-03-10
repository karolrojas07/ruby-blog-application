class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    @article = Article.find(params[:article_id])
    redirect_to article_path(@article), status: 303
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    @article = Article.find(params[:article_id])
    redirect_to article_path(@article), status: 303
  end
end
