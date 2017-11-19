FactoryBot.define do
  factory :event_without_required, class: Event do
    location Faker::Lorem.sentence
  end

  factory :event do
    title Faker::Lorem.sentence
    category Faker::Lorem.word

    factory :event_full do
      location Faker::Lorem.sentence
      description_short Faker::Lorem.sentence
      description Faker::Lorem.paragraph
      url Faker::Internet.url
      reg_url Faker::Internet.url
      image_url Faker::Internet.url
      video_url Faker::Internet.url
      date_start Faker::Date.between(Date.today, 10.days.from_now)
      date_end Faker::Date.between(11.days.from_now, 21.days.from_now)
      latitude Faker::Number.decimal(2, 3)
      longitude Faker::Number.decimal(2, 3)
      zoom Faker::Number.number(1)
      email Faker::Internet.email
      facebook Faker::Internet.url
      vk Faker::Internet.url
      twitter Faker::Internet.url
      pinterest Faker::Internet.url
      linkedin Faker::Internet.url
      odnoklasniki Faker::Internet.url
      googleplus Faker::Internet.url
      instagram Faker::Internet.url
      tumblr Faker::Internet.url
      youtube Faker::Internet.url
      hasReg Faker::Boolean.boolean
      hasParty Faker::Boolean.boolean
      hasMaps Faker::Boolean.boolean
      hasSponsors Faker::Boolean.boolean
      hasPartner Faker::Boolean.boolean
      hasPress Faker::Boolean.boolean
      hasTimeTable Faker::Boolean.boolean
      hasSpeakers Faker::Boolean.boolean
      hasProducts Faker::Boolean.boolean
      hasIndustryNews Faker::Boolean.boolean

      factory :event_today do
        date_start Faker::Date.between(10.days.ago, 2.days.ago)
        date_end Faker::Date.between(2.days.from_now, 21.days.from_now)
      end

      factory :event_not_today do
        date_start Faker::Date.between(2.days.from_now, 10.days.from_now)
        date_end Faker::Date.between(11.days.from_now, 21.days.from_now)
      end

      factory :event_with_unwanted do
        some :some
        unwanted :unwanted
        data_1 :data_1
      end

      factory :event_with_null_required do
        title nil
        category nil
      end

      factory :event_empty_required do
        title ''
        category ''
      end
    end
  end
end
