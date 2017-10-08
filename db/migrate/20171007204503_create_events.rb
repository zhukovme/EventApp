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
      t.boolean :hasReg, null: false, default: false
      t.boolean :hasParty, null: false, default: false
      t.boolean :hasMaps, null: false, default: false
      t.boolean :hasSponsors, null: false, default: false
      t.boolean :hasPartner, null: false, default: false
      t.boolean :hasPress, null: false, default: false
      t.boolean :hasTimeTable, null: false, default: false
      t.boolean :hasSpeakers, null: false, default: false
      t.boolean :hasProducts, null: false, default: false
      t.boolean :hasIndustryNews, null: false, default: false

    end
  end
end
