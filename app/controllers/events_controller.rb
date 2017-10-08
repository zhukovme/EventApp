class EventsController < ApplicationController

  def index
    date = parse_date params[:date]
    category = parse_category params[:category]
    limit = parse_limit params[:limit]

    events = Event.select(:id, :title, :category, :location, :image_url, 
        :date_start, :date_end)

    if date
      events = events.where(date_start: date.midnight..date.end_of_day)
        .or(events.where(date_end: date.midnight..date.end_of_day))
    end
    if category
      events = events.where(category: category)
    end
    if limit
      events = events.limit(limit)
    end

    render_200 events: events
  end

  def show
    event = Event.find(params[:id])
    render_200 event: event
  end

  def create
    validator = CreateEventValidator.new(params[:event])
    if validator.valid?
      Event.new(params[:event])
        .save
      render_200
    else
      render_400 reason: validator.reason
    end
  end

  def update
    validator = UpdateEventValidator.new(params[:event])
    if validator.valid?
      Event.find(params[:id])
        .update(params.fetch(:event, {}))
      render_200
    else
      render_400 reason: validator.reason
    end
  end

  def destroy
    event = Event.find(params[:id])
    if event.destroy
      render_200
    else
      render_500
    end
  end

  private

  def parse_date date
    begin
      params[:date].present? ? Date.parse(params[:date].delete("/\s/")) : nil
    rescue
      nil
    end
  end

  def parse_category category
    category.present? ? category.delete("/\s/").split(',') : nil
  end

  def parse_limit limit
    is_number?(limit) ? limit.delete("/\s/") : nil
  end

  def is_number? string
    true if Integer(string) rescue false
  end

end
