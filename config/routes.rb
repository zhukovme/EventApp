Rails.application.routes.draw do
  scope '/api' do
    resources :events
    resources :schedule_records, path: :schedule
    resources :news_posts
  end
end
