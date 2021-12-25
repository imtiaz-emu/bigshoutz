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
