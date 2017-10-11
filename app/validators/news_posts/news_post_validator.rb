class NewsPostValidator < Validator
  attr_reader :params, :news_post_params

  def initialize(params)
    @params = params.except(:news_post)
    @news_post_params = params[:news_post]
      .select { |x| NewsPost.attribute_names.index(x.to_s) }
  end
end
