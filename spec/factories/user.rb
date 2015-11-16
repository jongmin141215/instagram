FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    name  'Jongmin'
    password 'password'
    password_confirmation 'password'
  end

  factory :user2, class: User do
    email 'user2@example.com'
    name  'Jongmin2'
    password 'password'
    password_confirmation 'password'
  end
end
