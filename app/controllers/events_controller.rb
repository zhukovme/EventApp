class EventsController < ApplicationController

  def index
    date = parse_date(params[:date])
    categories = parse_categories(params[:categories])
    limit = parse_limit(params[:limit])

    events = Event.select(preview_attributes)
    events = events.where("date_start <= ?", date.end_of_day) if date
    events = events.where("date_end >= ?", date.midnight) if date
    events = events.where(category: categories) if categories
    events = events.limit(limit) if limit

    render_200(events: events)
  end

  def show
    event = Event.find(params[:id])
    render_200(event: event)
  end

  def create
    validator = CreateEventValidator.new(params[:event])
    if validator.valid?
      Event.new(params[:event]).save!
      render_200()
    else
      render_400(reason: validator.reason)
    end
  end

  def update
    validator = UpdateEventValidator.new(params[:event])
    if validator.valid?
      Event.find(params[:id]).update(params.fetch(:event, {}))
      render_200()
    else
      render_400(reason: validator.reason)
    end
  end

  def destroy
    event = Event.find(params[:id])
    if event.destroy
      render_200()
    else
      render_500()
    end
  end

  private

  def preview_attributes
    [:id, :title, :category, :location, :image_url, :date_start, :date_end]
  end

  def parse_date(date)
    Date.parse(params[:date]) if params[:date].present? rescue nil
  end

  def parse_categories(categories)
    if categories.present? && categories.is_a?(Array)
      categories.map { |category| category.strip }
    end
  end

  def parse_limit(limit)
    limit.strip if is_number?(limit)
  end

  def is_number?(string)
    true if Integer(string) rescue false
  end

end
