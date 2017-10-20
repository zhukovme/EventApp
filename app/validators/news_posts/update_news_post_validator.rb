class UpdateNewsPostValidator < Validator
  attr_reader :title, :category, :date

  validates :title, presence: { message: 'title_is_missing' },
    allow_nil: :true
  validates :category, presence: { message: 'category_is_missing' },
    allow_nil: :true
  validates :date, presence: { message: 'date_is_missing' },
    allow_nil: :true

  def initialize(news_post_params)
    @title = news_post_params[:title]
    @category = news_post_params[:category]
    @date = news_post_params[:date]
  end
end
