class EventValidator < Validator
  attr_reader :params, :event_params

  def initialize(params)
    @params = params.except(:event)
    @event_params = params[:event].select { |x| Event.attribute_names.index(x.to_s) }
  end
end
