# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


100.times do
  User.create(
    username: Faker::Twitter.user[:screen_name],
    description: Faker::Twitter.user[:description],
    password_digest: BCrypt::Password.create("password")
  )
end

user_id_list = (1..100).to_a

user_id_list.each do |id|
limit = (1..20).to_a.sample
list = user_id_list.shuffle
  for i in 1...limit do
    follower = list.shift
    Follow.create(
      following_id: id,
      follower_id: follower
    )
    Post.create(
      user_id: id,
      title: Faker::Movie.quote,
      content: Faker::Lorem.paragraph
    )
  end
end


for i in 1...2000 do
  PostLike.create(
    user_id: User.all.sample.id,
    post_id: Post.all.sample.id
  )
  Comment.create(
    user_id: User.all.sample.id,
    post_id: Post.all.sample.id,
    content: Faker::Lorem.paragraph
  )
end

# Create like
