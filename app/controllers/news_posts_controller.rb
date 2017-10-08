class NewsPostsController < ApplicationController

  def index
    category = parse_category params[:category]
    limit = parse_limit params[:limit]

    news_posts = NewsPost.select(preview_attributes)

    if category
      news_posts = news_posts.where(category: category)
    end
    if limit
      news_posts = news_posts.limit(limit)
    end

    render_200 news_posts: news_posts
  end

  def show
    news_post = NewsPost.find(params[:id])
    render_200 news_post: news_post
  end

  def create
    # validator = CreateNewsPostValidator.new(params[:news_post])
    # if validator.valid?
      NewsPost.new(params[:news_post])
        .save
      render_200
    # else
      # render_400 reason: validator.reason
    # end
  end

  def update
    # validator = UpdateNewsPostValidator.new(params[:news_post])
    # if validator.valid?
      NewsPost.find(params[:id])
        .update(params.fetch(:news_post, {}))
      render_200
    # else
      # render_400 reason: validator.reason
    # end
  end

  def destroy
    news_post = NewsPost.find(params[:id])
    if NewsPost.destroy
      render_200
    else
      render_500
    end
  end

  private

  def preview_attributes
    [:id, :title, :category, :rubric, :event_name, :image_url, :web_url, :date]
  end

  def parse_category category
    category.present? ? category.delete("/\s/").split(',') : nil
  end

  def parse_limit limit
    is_number?(limit) ? limit.delete("/\s/") : nil
  end

  def is_number? string
    true if Integer(string) rescue false
  end

end
