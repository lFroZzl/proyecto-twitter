class HomeController < ApplicationController
  def index
    if signed_in? && current_user.friends.count > 0
      @tweets = Tweet.tweets_for_me(current_user).order(created_at: :desc).page params[:page] 
    else
      @tweets = Tweet.order(created_at: :desc).page params[:page]
    end
    @tweet = Tweet.new
  end

  def all_tweets
    @tweets = Tweet.order(created_at: :desc).page params[:page]
    @tweet = Tweet.new
    
    render "index"
  end
end
