class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  
  def news

    #render json: Tweet.last(5)

    tweets = Tweet.last(20)
    hash = tweets.map do |tweet|

      { 

        id: tweet.id,
        content: tweet.content,
        user_id: tweet.user_id,
        like_count: tweet.likes.count,
        retweets_count: tweet.count_rt,
        retweeted_from: (tweet.rt_ref.nil? ? '-' : tweet.rt_ref)

       }

    end

    render json: hash

  end

  def tweets_by_date

    date1 = Date.parse(params[:date1])
    date2 = Date.parse(params[:date2])

    render json: Tweet.where(created_at: (date1..date2))

  end

  def create_tweet

    user = User.authenticate(params[:user][:email], params[:user][:password])
    if user.nil?
      render json: { error: 'invalid credentials' }
      return
    end
    
    @tweet = Tweet.new(tweet_params)
    @tweet.user = user
    if @tweet.save
      render json: @tweet, status: :created
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end


  private

    def tweet_params
      params.require(:tweet).permit(:content)
    end

end
