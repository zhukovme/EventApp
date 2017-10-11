class NewsPostsController < ApplicationController

  def index
    categories = parse_categories(params[:categories])
    limit = parse_limit(params[:limit])

    news_posts = NewsPost.select(preview_attributes)
    news_posts = news_posts.where(category: categories) if categories
    news_posts = news_posts.limit(limit) if limit

    render_200(news_posts: news_posts)
  end

  def show
    news_post = NewsPost.find(params[:id])
    render_200(news_post: news_post)
  end

  def create
    validator = CreateNewsPostValidator.new(params[:news_post])
    if validator.valid?
      NewsPost.new(params[:news_post]).save!
      render_200()
    else
      render_400(reason: validator.reason)
    end
  end

  def update
    validator = UpdateNewsPostValidator.new(params[:news_post])
    if validator.valid?
      NewsPost.find(params[:id]).update(params.fetch(:news_post, {}))
      render_200()
    else
      render_400(reason: validator.reason)
    end
  end

  def destroy
    news_post = NewsPost.find(params[:id])
    if news_post.destroy
      render_200()
    else
      render_500()
    end
  end

  private

  def preview_attributes
    [:id, :title, :category, :rubric, :event_name, :image_url, :web_url, :date]
  end

  def parse_categories(categories)
    if categories.present? && categories.is_a?(Array)
      categories.map { |category| category.strip }
    end
  end

  def parse_limit(limit)
    limit.strip if is_number?(limit)
  end

  def is_number?(string)
    true if Integer(string) rescue false
  end

end
