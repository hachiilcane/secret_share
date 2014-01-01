class Directory < ActiveRecord::Base
  has_many :photos
  attr_accessible :path, :modified_at, :is_ready_for_detail

  def got_ready_for_detail
    self.is_ready_for_detail = true
    save!
  end
end
