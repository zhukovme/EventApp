class EventsController < ApplicationController
  def index
    validator = IndexEventValidator.new(params)
    date = validator.date
    categories = validator.categories
    limit = validator.limit

    events = Event.select(index_columns)
    events = events.where('date_start <= ?', date.end_of_day)
      .where('date_end >= ?', date.midnight) if date
    events = events.where(category: categories) if categories
    events = events.limit(limit) if limit

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
    if event.destroy
      render_ok
    else
      render_error(:internal_server_error)
    end
  end

  private

  def index_columns
    %i[id title category location image_url date_start date_end]
  end

  def event_params
    (params[:event] || {})
      .select { |x| Event.attribute_names.index(x.to_s) }
  end
end
