class IndexScheduleRecordValidator < Validator
  attr_reader :event_id

  validates :event_id, presence: { message: 'event_id_is_missing' }

  def initialize(params)
    @event_id = params[:event_id]
  end
end
