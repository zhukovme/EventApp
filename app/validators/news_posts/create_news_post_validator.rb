class CreateNewsPostValidator < NewsPostValidator
  attr_reader :title, :category, :date

  validates :title, presence: { message: 'title_is_missing' }
  validates :category, presence: { message: 'category_is_missing' }
  validates :date, presence: { message: 'date_is_missing' }

  def initialize(params)
    super(params)
    @title = news_post_params[:title]
    @category = news_post_params[:category]
    @date = news_post_params[:date]
  end
end
