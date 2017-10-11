class UpdateEventValidator < EventValidator
  attr_reader :title, :category

  validate :any_nil_or_not_blank

  def initialize(params)
    super(params)
    @title = event_params[:title]
    @category = event_params[:category]
  end

  private

  def any_nil_or_not_blank
    errors[:base] << 'event_is_not_valid' unless nil_or_not_blank?(title) &&
                                                 nil_or_not_blank?(category)
  end

  def nil_or_not_blank?(param)
    param.nil? || !param.blank?
  end
end
