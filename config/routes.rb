Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    namespace :public_api do
      get 'locations/:country_code' => 'locations#index'
      get 'target_groups/:country_code' => 'target_groups#index'
    end

    namespace :private_api do
      get 'locations/:country_code' => 'locations#index'
      get 'target_groups/:country_code' => 'target_groups#index'
      post 'evaluate_target' => 'target_evaluations#create'
    end
  end
end
