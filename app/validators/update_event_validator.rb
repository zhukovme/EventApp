class UpdateEventValidator
  include ActiveModel::Model

  attr_accessor :title, :category, :location, :description_short, 
    :description, :url, :reg_url, :image_url, :video_url, :date_start, 
    :date_end, :latitude, :longitude, :zoom, :email, :facebook, :vk, :twitter, 
    :pinterest, :linkedin, :odnoklasniki, :googleplus, :instagram, :tumblr, 
    :youtube, :hasReg, :hasParty, :hasMaps, :hasSponsors, :hasPartner, 
    :hasPress, :hasTimeTable, :hasSpeakers, :hasProducts, :hasIndustryNews

  validate :any_nil_or_not_blank

  def reason
    errors.full_messages[0]
  end

  private

  def any_nil_or_not_blank
    unless (nil_or_not_blank?(title) && nil_or_not_blank?(category))
        errors[:base] << "event_is_not_valid"
    end
  end

  def nil_or_not_blank?(param)
    param.nil? || !param.blank?
  end

end