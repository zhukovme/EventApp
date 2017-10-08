class UpdateEventValidator
  include ActiveModel::Model

  attr_accessor :title, :category, :location, :description_short, 
    :description, :url, :reg_url, :image_url, :video_url, :date_start, 
    :date_end, :latitude, :longitude, :zoom, :email, :facebook, :vk, :twitter, 
    :pinterest, :linkedin, :odnoklasniki, :googleplus, :instagram, :tumblr, 
    :youtube, :hasReg, :hasParty, :hasMaps, :hasSponsors, :hasPartner, 
    :hasPress, :hasTimeTable, :hasSpeakers, :hasProducts, :hasIndustryNews

  validate :any_not_nil_is_not_blank

  def reason
    "event_is_not_valid"
  end

  private
  def any_not_nil_is_not_blank
    if (!title.nil? && title.blank?) || (!category.nil? && category.blank?)
      errors[:base] << "event_is_not_valid"
    end
  end
  
end