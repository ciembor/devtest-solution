FactoryGirl.define do
  factory :api_key do
    token 'secret_api'
  end

  factory :panel_provider do
    code 'PanelServiceClassName'
  end

  factory :location do
    sequence(:name) { |n| "Location #{n}" }
    sequence(:secret_code) { |n| "Secret code #{n} for location" }
  end

  factory :location_group do
    sequence(:name) { |n| "Location group #{n}" }
    association :panel_provider
    association :country
  end

  factory :country do
    sequence(:country_code) { |n| "country#{n}" }
    association :panel_provider
  end

  factory :target_group do
    sequence(:name) { |n| "Target group #{n}" }
    sequence(:secret_code) { |n| "Secret code #{n} for target_group" }
    association :panel_provider
  end
end
