class UpdateNewsPostValidator < NewsPostValidator
  attr_reader :title, :category, :date

  validate :any_nil_or_not_blank

  def initialize(params)
    super(params)
    @title = news_post_params[:title]
    @category = news_post_params[:category]
    @date = news_post_params[:date]
  end

  private

  def any_nil_or_not_blank
    unless nil_or_not_blank?(title) &&
           nil_or_not_blank?(category) &&
           nil_or_not_blank?(date)
      errors[:base] << 'news_post_is_not_valid'
    end
  end

  def nil_or_not_blank?(param)
    param.nil? || !param.blank?
  end
end
