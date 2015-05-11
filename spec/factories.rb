FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:username) { |n| "name #{n}" }
    sequence(:email) { |n| "email_#{n}@gmail.com" }
    password "sample"
    password_confirmation "sample"

    factory :admin do
      admin true
    end
  end

  factory :friend, class: User do
    name     "marcelo salas"
    username "matador"
    sequence(:email) { |n| "elmatador_#{n}@gmail.com" }
    password "blabla#"
    password_confirmation "blabla#"
  end

  factory :post do
    content "Lorem ipsum"
    user
  end
end
