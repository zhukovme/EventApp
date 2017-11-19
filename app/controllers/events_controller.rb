class EventsController < ApplicationController
  def index
    validator = IndexEventValidator.new(params)
    date = validator.date
    categories = validator.categories
    limit = validator.limit

    events = Event.select(Event.preview_attribute_names)
    events.where!('date_start <= ?', date.end_of_day)
      .where!('date_end >= ?', date.midnight) if date
    events.where!(category: categories) if categories
    events.limit!(limit) if limit

    render_ok(events: events)
  end

  def show
    event = Event.find(params[:id])
    render_ok(event: event)
  end

  def create
    validator = CreateEventValidator.new(event_params)
    if validator.valid?
      Event.new(event_params).save!
      render_ok
    else
      render_error(:bad_request, reason: validator.reason)
    end
  end

  def update
    validator = UpdateEventValidator.new(event_params)
    if validator.valid?
      Event.find(params[:id]).update!(event_params)
      render_ok
    else
      render_error(:bad_request, reason: validator.reason)
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy!
    render_ok
  end

  private

  def event_params
    (params[:event] || {})
      .select { |k, v| Event.attribute_names.include?(k) }
  end
end
