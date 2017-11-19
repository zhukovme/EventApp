class UpdateEventValidator < Validator
  attr_reader :event_params, :title, :category

  validate :validate_presence

  def initialize(event_params)
    @event_params = event_params
    @title = event_params[:title]
    @category = event_params[:category]
  end

  def validate_presence
    errors[:base] << 'title_is_missing' if
      event_params.has_key?(:title) && title.blank?
    errors[:base] << 'category_is_missing' if
      event_params.has_key?(:category) && category.blank?
  end
end
