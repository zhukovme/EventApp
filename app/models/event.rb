class Event < ActiveRecord::Base
  has_many :schedule_records, dependent: :destroy

  def self.preview_attribute_names
    ['id', 'title', 'category', 'location', 'image_url', 'date_start',
    'date_end']
  end

  def preview_attributes
    attributes.select { |k, v| Event.preview_attribute_names.include?(k) }
  end
end
