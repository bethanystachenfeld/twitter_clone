class TweetsController < ApplicationController
	before_action :set_tweet, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!

  def index
  	    @tweets = Tweet.all
  end

  def show
  end

  def new
  	@tweet = Tweet.new
  end


  def edit
  end

def create
	@tweet = Tweet.new(tweet_params)

	respond_to do |format|
	   if @tweet.save
	     format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
	   else
	     format.html { render :new }
	   end
	end
end

def update
    respond_to do |format|
    	if @tweet.update(tweet_params)
    		format.html { redirect_to @tweet, notice: 'Post was successfully updated.' }
    	else
    		format.html { render :edit }
    	end
    end
end 

def destroy
    @tweet.destroy
  respond_to do |format|
    format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
  end
end 

 private
    # Using a private method to encapsulate the permissible parameters is
    # a good pattern since you'll be able to reuse the same permit
    # list between create and update. Also, you can specialize this method
    # with per-user checking of permissible attributes.
    def set_tweet
    	@tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:user_id, :message)
    end  
end
