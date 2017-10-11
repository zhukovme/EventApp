class UpdateNewsPostValidator
  include ActiveModel::Model

  attr_accessor :title, :category, :rubric, :event_name, :image_url, :web_url,
    :date, :description

  validate :any_nil_or_not_blank

  def reason
    errors.full_messages[0]
  end

  private

  def any_nil_or_not_blank
    unless (nil_or_not_blank?(title) && 
        nil_or_not_blank?(category) && 
        nil_or_not_blank?(date))
      errors[:base] << "news_post_is_not_valid"
    end
  end

  def nil_or_not_blank?(param)
    param.nil? || !param.blank?
  end

end