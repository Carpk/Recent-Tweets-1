require 'twitter'

get '/' do
  erb :index
end


get '/user' do
  redirect to '/' + params[:username]
end


get '/:username' do

  @user = TwitterUser.find_by_username(params[:username])
  if @user
    if @user.tweets.empty?
      # User#fetch_tweets! should make an API call
      # and populate the tweets table
      #
      # Future requests should read from the tweets table
      # instead of making an API call
      @user.fetch_tweets!
    end
  else
    @user = TwitterUser.create(username: params[:username])
    if @user.tweets.empty?
      # User#fetch_tweets! should make an API call
      # and populate the tweets table
      #
      # Future requests should read from the tweets table
      # instead of making an API call
      @user.fetch_tweets!
    end
  end
  # @user.tweets.each {|tweet| tweet.body }
  @tweets = @user.tweets.limit(10)
  erb :user
end