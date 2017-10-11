class CreateNewsPostValidator < NewsPostValidator
  attr_reader :title, :category, :date

  validates :title, :category, :date, presence: true

  def initialize(params)
    super(params)
    @title = news_post_params[:title]
    @category = news_post_params[:category]
    @date = news_post_params[:date]
  end
end
