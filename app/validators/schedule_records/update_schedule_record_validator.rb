class UpdateScheduleRecordValidator < Validator
  attr_reader :title

  validates :title, presence: { message: 'title_is_missing' },
    allow_nil: :true

  def initialize(schedule_record_params)
    @title = schedule_record_params[:title]
  end
end
