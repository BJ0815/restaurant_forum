namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(
        remote_image_url: 'http://fakeimg.pl/300/',
        name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
        favorites_count: rand(1..100)
        )
    end
    puts "have created fake restaurants"
    puts "how you have #{Restaurant.count} restaurants data"
  end

  task fake_user: :environment do

    20.times do |i|
      User.create!(
        name: FFaker::Name.first_name,
        email: FFaker::Internet.email,
        password: FFaker::Internet.password
        )
    end
    puts "have created fake users"
    puts "how you have #{User.count} users"
  end

  task fake_comment: :environment do
    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(content: FFaker::LoremCN.paragraphs,
          user: User.all.sample
          )
      end
    end
    puts "have created fake comment"
    puts "how you have #{Comment.count} comments"
  end
end
