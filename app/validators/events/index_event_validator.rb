class IndexEventValidator < Validator
  attr_reader :date, :categories, :limit

  def initialize(params)
    @date = validate_date(params[:date])
    @categories = validate_array(params[:categories])
    @limit = validate_int(params[:limit])
  end

  private

  def validate_date(date)
    Time.zone.strptime(date.strip, '%d.%m.%Y') if date.present? rescue nil
  end
end
