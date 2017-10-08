class EventsController < ApplicationController

  def index
    events = Event.select [:id, :title, :category, :location, :image_url, 
      :date_start, :date_end]
    render_200 events: events
  end

  def show
    event = Event.find(params[:id])
    render_200 event: event
  end

  def create
    validator = AddEventValidator.new(params[:event])
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

end
