class User < ApplicationRecord
  validates :username, uniqueness: true, length: {in: 2..12}, presence: :true
  has_secure_password

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  has_many :posts
  has_many :post_likes

  has_many :comments


  def find_follow(post_user_id)
    Follow.where("follower_id = #{self.id} AND following_id = #{post_user_id}").first
  end

  def follow_user(post_user_id)
    self.following << User.find(post_user_id)
    self.save
  end

  def unfollow_user(post_user_id)
    Follow.destroy(find_follow(post_user_id).id)
  end

  def find_like(post_id)
      PostLike.where("post_id = #{post_id} AND user_id = #{self.id}")
  end

  def like_post(post_id)
    post = Post.find(post_id)
    post.users << self
  end

  def unlike_post(post_id)
    like = find_like(post_id)
    PostLike.destroy(like.ids.first)
  end

  def amt_followers
    self.followers.count
  end

  def amt_following
    self.following.count
  end
end
