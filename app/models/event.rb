class Event < ActiveRecord::Base
  has_many :schedule_records, dependent: :destroy
end
