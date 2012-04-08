FactoryGirl.define do
  factory :directory_ready, :class => Directory do
    path "2011/09/10"
    modified_at Time.parse("2011-09-13 08:45:11")
    is_ready_for_detail true
  end

  factory :directory_not_ready, :class => Directory do
    path "2011/09/12"
    modified_at Time.parse("2011-10-14 11:56:02")
    is_ready_for_detail false
  end

  factory :directory_1, :class => Directory do
    path "2011/10/06"
    modified_at Time.parse("2011-12-13 03:11:11")
    is_ready_for_detail true
  end

  factory :directory_2, :class => Directory do
    path "2012/01/02"
    modified_at Time.parse("2012-01-10 22:52:07")
    is_ready_for_detail true
  end

  factory :directory_has_photo, :class => Directory do
    path "2011/03/20"
    modified_at Time.parse("2011-04-02 22:52:07")
    is_ready_for_detail true
    photos {[Factory(:photo_1)]}
  end

  factory :directory_has_2photos, :class => Directory do
    path "2011/03/20"
    modified_at Time.parse("2011-04-02 22:52:07")
    is_ready_for_detail true
    photos {[Factory(:photo_2), Factory(:photo_1)]}
  end
end
