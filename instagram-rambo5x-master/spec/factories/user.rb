FactoryBot.define do
    factory :user do
        sequence(:email) { |n| "person-#{n}@example.com" }
        password { '123greetings' }

        factory :user_with_posts do
            transient do
              posts_count { 10 }
            end
      
            after(:create) do |user, evaluator|
              create_list(:post, evaluator.posts_count, :valid, user: user)
            end
        end
    end
  end