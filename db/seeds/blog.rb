# rails db:seed:blog to run this seed
# Be aware that this will reset all Blog related content
titles = [
  "The 10 Secrets You Will Never Know About Food.",
  "Five Things You Didn't Know About Food.",
  "5 Things You Should Do In Food.",
  "Skills That You Can Learn From Food.",
  "Seven Doubts About Food You Should Clarify.",
  "How To Leave News Without Being Noticed.",
  "Here's What Industry Insiders Say About News.",
  "The Modern Rules Of Ads.",
  "Here's What Industry Insiders Say About Ads.",
  "Understanding The Background Of Programming.",
  "This Is Why Cat Are So Famous!",
  "The Miracle Of Cat.",
  "How to Save Money on Europe",
  "How Technology Is Changing How We Treat Europe"
]

comments = [
  'Outstandingly thought out! Engaging. It keeps your mind occupied while you wait.',
  'This concept blew my mind.',
  "I think I'm crying. It's that neat.",
  "Nice use of green in this design m8",
  "It's gorgeous not just sleek!",
  "I’m honored to be included and mentioned",
  "Thank you for clarifying how you launched your blog",
  "Niiiice!",
  "I'll share this for sure!",
  "Thanks!!!"
]

subcategories = [
  'Movie Titles',
  'Halloween Costumes',
  'Musical Groups',
  'Breakfast Foods',
  'Desserts',
  'Sandwiches',
  'Diet Foods',
  'Beers',
  'Appliances',
]

ActiveRecord::Base.transaction do
  [
    BlogCategory,
    BlogComment,
    BlogSubcategory,
    BlogPost
  ].each do |klass|
    klass.destroy_all
  end

  BlogCategory.create!(title: 'Start your business')
  BlogCategory.create!(title: 'Promote your business')
  BlogCategory.create!(title: 'Scale your business')
  BlogCategory.create!(title: 'Increase your business')

  BlogCategory.all.each do |bc|
    Faker::Number.between(from: 2, to: 4).times do
      bc.blog_subcategories.create!(title: subcategories.sample)
    end
  end

  users = []

  4.times do
    profile_photo  = File.open(File.join(Rails.root,"test/images/#{['user-1.png', 'user-2.png', 'user-3.png', 'user-4.png', 'user-5.png', 'user-6.png'].sample}"))
    users.push(User.create!(email: Faker::Internet.email, profile_photo: profile_photo, first_name: Faker::Name.first_name, last_name: Faker::Name.first_name, password: "password", password_confirmation: "password", language: "English", created_at: "2016-10-02 22:04:15", updated_at: "2016-10-02 22:04:15", nomoderation: true, confirmed_at: Time.now))
  end

  100.times do
    cover_photo  = File.open(File.join(Rails.root,"test/images/#{['image-1.jpeg', 'image-2.jpeg', 'image-3.png', 'image-4.jpeg', 'image-5.png'].sample}"))
    author_photo  = File.open(File.join(Rails.root,"test/images/#{['user-1.png', 'user-2.png', 'user-3.png'].sample}"))

    post = BlogPost.create!(
      title: titles.sample,
      tag: 'test',
      cover_photo: cover_photo,
      blog_subcategory_id: BlogSubcategory.all.sample.id,
      content: Faker::Lorem.paragraphs(number: 10).map{|pr| "<p>#{pr}</p>"}.join(' '),
      featured: [true, false].sample,
      author: Faker::Name.name,
      author_photo: author_photo,
      status: [:published, :draft].sample,
      bio: Faker::Lorem.paragraphs(number: Faker::Number.between(from: 1, to: 3)).join()
    )

    Faker::Number.between(from: 0, to: 6).times do
      BlogComment.create(
        content: comments.sample,
        user_id: users.sample.id,
        blog_post_id: post.id,
        status: [:hidden, :published].sample
      )
    end
  end

  puts "Blog Post #{BlogPost.published.count} as draft created"
  puts "Blog Post #{BlogPost.draft.count} as published created"
  puts "Blog Comment #{BlogComment.count} as published created"
  puts "Blog Category #{BlogCategory.count} created"
  puts "Blog Subcategory #{BlogSubcategory.count} created"
end