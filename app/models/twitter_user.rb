class TwitterUser < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  def fetch_tweets!
    # twitter_user = TwitterUser.find_by_username(username)
    tweets = Twitter.user_timeline(username)
    tweets.each do |tweet|
      Tweet.create(twitter_user_id: self.id, body: tweet.text)
    end
  end
end
