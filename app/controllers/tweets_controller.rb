class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    @tweets = Tweet.order(id: :desc).page params[:page]
  end

  def new
    @tweet = Tweet.new
  end

  def create
    # @tweet = Tweet.new
    Tweet.create(tweet_params)
    # @tweet.save
    redirect_to '/'
  end

  def show
    # 1개의 tweet만
  end

  def edit
    # 수정한 트윗, 수정하는 form
  end

  def update
    # 실제로 수정
    @tweet.update(tweet_params)
    redirect_to tweet_path(@tweet)
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path
    # 지우는 것
  end

  private
  def set_tweet()
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:title, :content, :user_id, :photo_url)
  end

end
