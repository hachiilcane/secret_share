FactoryGirl.define do
  factory :photo_1, :class => Photo do
    full_name "/test/2011_03_20/photo001.jpg"
    date_time_original Time.parse("2011-03-20 10:11:44")
  end

  factory :photo_2, :class => Photo do
    full_name "/test/2011_03_20/photo002.jpg"
    date_time_original Time.parse("2011-03-20 10:13:22")
  end
end
