class CreateEventValidator < EventValidator
  attr_reader :title, :category

  validates :title, presence: { message: 'title_is_missing' }
  validates :category, presence: { message: 'category_is_missing' }

  def initialize(params)
    super(params)
    @title = event_params[:title]
    @category = event_params[:category]
  end
end
