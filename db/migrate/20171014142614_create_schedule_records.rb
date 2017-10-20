class CreateScheduleRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :schedule_records do |t|
      t.belongs_to :event

      t.text :title, null: false
      t.text :place
      t.datetime :time_start
      t.integer :duration
      t.text :description

    end
  end
end
