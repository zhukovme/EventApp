class ScheduleRecordsController < ApplicationController
  def index
    event_id = params[:event_id]
    if event_id.present?
      schedule = ScheduleRecord.select(index_columns)
        .where(event_id: event_id)
      render_ok(schedule: schedule)
    else
      render_error(:bad_request, reason: :event_id_is_missing)
    end
  end

  def show
    schedule_record = ScheduleRecord.find(params[:id])
    render_ok(schedule_record: schedule_record)
  end

  def create
    event_id = params[:event_id]
    validator = CreateScheduleRecordValidator.new(event_id, 
                                                  schedule_record_params)
    if validator.valid?
      Event.find(event_id).schedule_records.new(schedule_record_params).save!
      render_ok
    else
      render_error(:bad_request, reason: validator.reason)
    end
  end

  def update
    validator = UpdateScheduleRecordValidator.new(schedule_record_params)
    if validator.valid?
      ScheduleRecord.find(params[:id]).update!(schedule_record_params)
      render_ok
    else
      render_error(:bad_request, reason: validator.reason)
    end
  end

  def destroy
    schedule_record = ScheduleRecord.find(params[:id])
    if schedule_record.destroy
      render_ok
    else
      render_error(:internal_server_error)
    end
  end

  private

  def index_columns
    %i[id event_id title time_start duration place]
  end

  def schedule_record_params
    (params[:schedule_record] || {})
      .select { |x| ScheduleRecord.attribute_names.index(x.to_s) }
  end
end
