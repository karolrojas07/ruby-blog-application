# frozen_string_literal: true

# Controller to handle HTTP Request for Article CRUD
class ArticlesController < ApplicationController
  # http_basic_authenticate_with name: 'dhh', password: 'secret', except: %i[index show]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    if user_signed_in?
      @user = current_user
      @article = @user.articles.create(article_params)
      redirect_to article_path(@article)

    # if @article.save
    # redirects the browser to the article's page at
    # "http://localhost:3000/articles/#{@article.id}"

    else
      # the action redisplays the form by rendering
      # app/views/articles/new.html.erb
      # with status code 422 Unprocessable Entity.
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end

# redirect_to will cause the browser to make a new request,
# whereas render renders the specified view for the current request.
# It is important to use redirect_to after mutating the database or application state.
# Otherwise, if the user refreshes the page, the browser will make the same request,
# and the mutation will be repeated.
