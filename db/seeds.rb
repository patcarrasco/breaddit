# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Post.destroy_all
Comment.destroy_all
PostLike.destroy_all
Follow.destroy_all

image_links = [
  "https://petcentral.chewy.com/wp-content/uploads/2018/05/clotheslg.jpg",
  "https://petcentral.chewy.com/wp-content/uploads/2018/05/jiffpom-x-670-600x.jpg",
  "https://petcentral.chewy.com/wp-content/uploads/2018/05/dudetheboston-x-670-600x.jpg",
  "https://images.gawker.com/18d11anlt344njpg/c_fit,fl_progressive,q_80,w_470.jpg",
  "https://66.media.tumblr.com/024e9d168f946bfe00055eb5e30f80da/tumblr_mgu3b1fjo71rg9pn0o1_500.jpg",
  "https://maydailyblog.files.wordpress.com/2014/03/dog-e1395762965280.jpg",
  "https://static.tumblr.com/ca21058c0fc3d2503801d425ed116649/cwibmwk/YJKnjrwno/tumblr_static_tumblr_static_3uy1o7uacg6cowc480kc4cgwk_640.jpg",
  "https://i.pinimg.com/originals/06/bc/f2/06bcf2190b80dc419fd70568ab9fa74b.jpg",
  "http://i.imgur.com/XB0JE.jpg",
  "https://i.pinimg.com/originals/b9/26/14/b92614ae578d6093ce87ab58933f61c5.jpg",
  "https://pics.me.me/funny-14349013.png",
  "https://i.pinimg.com/originals/94/cb/7c/94cb7c1347b897af9b2d41d5f991fec1.jpg",
  "https://i.dailymail.co.uk/i/pix/2014/10/15/1413409646811_Image_galleryImage__EXCLUSIVE_STRICT_ONLINE_.JPG",
  "https://i.dailymail.co.uk/i/pix/2014/07/21/article-2699640-1FD06DD900000578-538_634x600.jpg",
  "https://cdn-img.instyle.com/sites/default/files/styles/622x350/public/images/2017/03/030117-menswear-dog-lead.jpg?itok=aT8F4_PN"
]


100.times do
  User.create(
    username: Faker::Twitter.user[:screen_name],
    description: Faker::Twitter.user[:description],
    password_digest: BCrypt::Password.create("password")
  )
end

user_id_list = (1..100).to_a
limit = (1..20).to_a.sample
list = user_id_list.shuffle


user_id_list.each do |id|
  for i in 1...limit do
    follower = list.shift
    Follow.create(
      following_id: id,
      follower_id: follower
    )
    post = Post.create(
      user_id: id,
      content: Faker::Movie.quote,
    )

    post.image = image_links.sample
    post.save
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
