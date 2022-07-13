FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test_user#{n}@mail.com" }
    password { '12345678' }
    password_confirmation { '12345678' }

    trait :with_name do
      sequence(:name) { |n| "User#{n}" }
    end

    trait :with_fullname do
      sequence(:name) { |n| "User#{n}" }
      sequence(:last_name) { |n| "Surname#{n}" }
    end

    trait :with_full_info do
      sequence(:name) { |n| "User#{n}" }
      sequence(:last_name) { |n| "Surname#{n}" }
      sequence(:nickname) { |n| "Alias#{n}" }
    end
  end
end
