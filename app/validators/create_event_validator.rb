class CreateEventValidator
  include ActiveModel::Model

  attr_accessor :title, :category, :location, :description_short, 
    :description, :url, :reg_url, :image_url, :video_url, :date_start, 
    :date_end, :latitude, :longitude, :zoom, :email, :facebook, :vk, :twitter, 
    :pinterest, :linkedin, :odnoklasniki, :googleplus, :instagram, :tumblr, 
    :youtube, :hasReg, :hasParty, :hasMaps, :hasSponsors, :hasPartner, 
    :hasPress, :hasTimeTable, :hasSpeakers, :hasProducts, :hasIndustryNews

  validates :title, :category, presence: true

  def reason
    errors.full_messages[0]
  end
  
end