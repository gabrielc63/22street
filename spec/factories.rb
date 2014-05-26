FactoryGirl.define do
  factory :user do
    name     "calvin klein"
    username "calvink"
    email    "calvin@example.com"
    avatar   File.new("app/assets/images/ruby.png")
    password "mentira"
    password_confirmation "mentira"
  end

  factory :friend, class: User do
    name     "marcelo salas"
    username "matador"
    email    "elmatador@gmail.com"
    avatar   File.new("app/assets/images/ruby.png")
    password "blabla#"
    password_confirmation "blabla#"
  end

  factory :post do
    content "Lorem ipsum"
    user
  end
end
