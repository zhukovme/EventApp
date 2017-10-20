class CreateScheduleRecordValidator < Validator
  attr_reader :event_id, :title

  validates :event_id, presence: { message: 'event_id_is_missing' }
  validates :title, presence: { message: 'title_is_missing' }

  def initialize(event_id, schedule_record_params)
    @event_id = event_id
    @title = schedule_record_params[:title]
  end
end
