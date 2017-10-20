class ScheduleRecord < ActiveRecord::Base
  belongs_to :event

  validates :title, presence: { message: 'title_is_missing' }
end
