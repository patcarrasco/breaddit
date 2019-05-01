class Post < ApplicationRecord


  validates :title, presence: true, length: {in: 1...50}
  validates :content, presence: true, length: {maximum: 3000 }

  belongs_to :user
  has_many :post_likes
  has_many :users, through: :post_likes

  has_many :comments

  paginates_per 24


  def amt_likes
    self.users.count
  end

  def recent_comments
    return comments.first(5)
  end

end
