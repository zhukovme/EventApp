class NewsPostsController < ApplicationController
  def index
    categories = parse_categories(params[:categories])
    limit = parse_limit(params[:limit])

    news_posts = NewsPost.select(index_columns)
    news_posts = news_posts.where(category: categories) if categories
    news_posts = news_posts.limit(limit) if limit

    render_ok(news_posts: news_posts)
  end

  def show
    news_post = NewsPost.find(params[:id])
    render_ok(news_post: news_post)
  end

  def create
    validator = CreateNewsPostValidator.new(news_post_params)
    if validator.valid?
      NewsPost.new(news_post_params).save!
      render_ok
    else
      render_error(:bad_request, reason: validator.reason)
    end
  end

  def update
    validator = UpdateNewsPostValidator.new(news_post_params)
    if validator.valid?
      NewsPost.find(params[:id]).update!(news_post_params)
      render_ok
    else
      render_error(:bad_request, reason: validator.reason)
    end
  end

  def destroy
    news_post = NewsPost.find(params[:id])
    if news_post.destroy
      render_ok
    else
      render_error(:internal_server_error)
    end
  end

  private

  def index_columns
    %i[id title category rubric event_name image_url web_url date]
  end

  def parse_categories(categories)
    categories.map(&:strip) if categories.present? && categories.is_a?(Array)
  end

  def parse_limit(limit)
    limit.strip if number?(limit)
  end

  def news_post_params
    (params[:news_post] || {})
      .select { |x| NewsPost.attribute_names.index(x.to_s) }
  end
end
