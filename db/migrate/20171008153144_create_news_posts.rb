class CreateNewsPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :news_posts do |t|

      t.text :title, null: false
      t.text :category, null: false
      t.text :rubric
      t.text :event_name
      t.text :image_url
      t.text :web_url
      t.datetime :date, null: false
      t.text :description
      
    end
  end
end
