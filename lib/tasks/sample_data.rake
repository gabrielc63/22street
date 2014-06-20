namespace :db do
  desc "Fill database with data"
  task populate: :environment do
    User.create!(name: "Fake user",
                 username: "username",
                 email: "fakeuser@gmail.com",
                 password: "sample123",
                 password_confirmation: "sample123")
    30.times do |n|
      name  = Faker::Name.name
      username  = "name-#{n+1}"
      email = "fake_email-#{n+1}@gmail.com"
      password  = "password"
      User.create!(name: name,
                   username: username,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
