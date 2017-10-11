class CreateNewsPostValidator
  include ActiveModel::Model

  attr_accessor :title, :category, :rubric, :event_name, :image_url, :web_url,
    :date, :description

  validates :title, :category, :date, presence: true

  def reason
    errors.full_messages[0]
  end

end