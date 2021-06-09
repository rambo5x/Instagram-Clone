FactoryBot.define do
    factory :post do
        user

        trait :valid do
            sequence(:image_url) { |n| "http://www.google.com/#{n}.jpeg" }
        end

        trait :url_is_not_image do
            sequence(:image_url) { |n| "http://www.google.com/#{n}" }
        end

        trait :missing_url do
            image_url { "" }
        end
    end
end