class IndexNewsPostValidator < Validator
  attr_reader :categories, :limit

  def initialize(params)
    @categories = validate_array(params[:categories])
    @limit = validate_int(params[:limit])
  end
end
