require 'twitter'

get '/' do
  erb :index
end


get '/user' do
  redirect to '/user/' + params[:username]
end


get '/user/:username' do
  @user = TwitterUser.find_by_username(params[:username])
  if @user
    if @user.tweets.empty?
      @user.fetch_tweets!
    end
  else
    @user = TwitterUser.create(username: params[:username])
    if @user.tweets.empty?
      @user.fetch_tweets!
    end
  end
  @tweets = @user.tweets.limit(10)
  erb :user
end

get '/tweet' do
  erb :create_tweet
end

post '/tweet' do
  Twitter.update(params[:body])
  erb :index
end