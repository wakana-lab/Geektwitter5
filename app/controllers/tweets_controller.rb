class TweetsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tweets = Tweet.all
    search = params[:search]
    if search.present?
      @tweets = @tweets.joins(:user).where("body LIKE ? OR name LIKE ?", "%#{search}%", "%#{search}%")
    end
    @tweets = @tweets.page(params[:page]).per(3)
  
    if params[:tag_ids]
      @tweets = []
      params[:tag_ids].each do |key, value|      
        @tweets += Tag.find_by(name: key).tweets if value == "1"
      end
      @tweets.uniq!
    end

    if params[:tag]
      Tag.create(name: params[:tag])
    end
  
  end

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    if tweet.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments
    @comment = Comment.new
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to :action => "show", :id => tweet.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  private
  def tweet_params
    params.require(:tweet).permit(:body,:image,tag_ids: [])
  end
end
