Rails.application.routes.draw do

  scope '/api' do
    resources :events
    resources :news_posts
  end

end
