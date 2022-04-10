require 'faker'

%w[Admin Talent Fan Celebrity].each do |role|
  Role.where(name: role).first_or_create
end

puts('1. Roles created')

unless User.find_by(email: 'admin@bigshoutz.com')
  user = User.new(email: 'admin@bigshoutz.com', password: '123123123')
  user.skip_confirmation_notification!
  user.confirmed_at = DateTime.now
  user.save!

  user.roles << Role.find_by(name: 'Admin')
end

puts('2. Admin User created')

%w[Upvote Downvote].each do |addon_name|
  unless Addon.find_by(name: addon_name)
    Addon.create(name: addon_name, description: Faker::Lorem.paragraph, price: 1.0)
  end
end

puts('3. Addons created')

# Create test Users, Services, Listings to populate the database
# ['Hangout', 'Live Video'].each do |service|
#   Service.new(title: service, description: Faker::Lorem.paragraph).save!
# end

# 3.times do |i|
#   user = User.new(email: "ce#{i+1}@bigshoutz.com", password: '123123123')
#   user.skip_confirmation_notification!
#   user.confirmed_at = DateTime.now
#   user.save!
#
#   user.roles << Role.find_by(name: 'Celebrity')
#
#   listing = Listing.new(
#       owner_id: user.id,
#       service_id: Service.all.sample.id,
#       name: Faker::Lorem.sentence,
#       description: Faker::Lorem.paragraph,
#       available_on: Time.now + 7.days,
#       price: Faker::Number.decimal(l_digits: 3, r_digits: 2),
#       currency: Faker::Currency.code,
#       meta_keywords: Faker::Lorem.words.join(','),
#       event_time: Time.now + 10.days,
#       event_place: Faker::Address.full_address
#   )
#
#   listing.uploads.attach(
#       io: File.open("/Users/imtiaz/adzymic/SampleImages/300x250/300x250_#{i+1}.jpg"),
#       filename: "300x250_#{i+1}.jpg",
#       content_type: 'image/jpg'
#   )
#
#   listing.save!
# end

# 2.times do |i|
#   user = User.new(email: "ta#{i+1}@bigshoutz.com", password: '123123123')
#   user.skip_confirmation_notification!
#   user.confirmed_at = DateTime.now
#   user.save!
#
#   user.roles << Role.find_by(name: 'Talent')
#
#   listing = user.listings.new(
#       service_id: Service.all.sample.id,
#       name: Faker::Lorem.sentence,
#       description: Faker::Lorem.paragraph,
#       available_on: Time.now + 7.days,
#       price: Faker::Number.decimal(l_digits: 3, r_digits: 2),
#       currency: Faker::Currency.code,
#       meta_keywords: Faker::Lorem.words.join(','),
#       event_time: Time.now + 10.days,
#       event_place: Faker::Address.full_address
#   )
#
#   listing.uploads.attach(
#       io: File.open("/Users/imtiaz/adzymic/SampleImages/300x250/300x250_#{i+1}.jpg"),
#       filename: "300x250_#{i+1}.jpg",
#       content_type: 'image/jpg'
#   )
# end
#
# 4.times do |i|
#   user = User.new(email: "fa#{i+1}@bigshoutz.com", password: '123123123')
#   user.skip_confirmation_notification!
#   user.confirmed_at = DateTime.now
#   user.save!
#
#   user.roles << Role.find_by(name: 'Fan')
# end
