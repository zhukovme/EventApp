Rails.application.routes.draw do
  scope '/api' do
    resources :events, :except => [:new, :edit]
    resources :news_posts, :except => [:new, :edit]
  end
end
