class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      
      t.text :title, null: false
      t.text :category, null: false
      t.text :location
      t.text :description_short
      t.text :description
      t.text :url
      t.text :reg_url
      t.text :image_url
      t.text :video_url
      t.datetime :date_start
      t.datetime :date_end
      t.decimal :latitude
      t.decimal :longitude
      t.integer :zoom
      t.text :email
      t.text :facebook
      t.text :vk
      t.text :twitter
      t.text :pinterest
      t.text :linkedin
      t.text :odnoklasniki
      t.text :googleplus
      t.text :instagram
      t.text :tumblr
      t.text :youtube
      t.boolean :hasReg
      t.boolean :hasParty
      t.boolean :hasMaps
      t.boolean :hasSponsors
      t.boolean :hasPartner
      t.boolean :hasPress
      t.boolean :hasTimeTable
      t.boolean :hasSpeakers
      t.boolean :hasProducts
      t.boolean :hasIndustryNews

      t.timestamps
    end
  end
end
