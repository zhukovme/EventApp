class CreateEventValidator < EventValidator
  attr_reader :title, :category

  validates :title, :category, presence: true

  def initialize(params)
    super(params)
    @title = event_params[:title]
    @category = event_params[:category]
  end
end
