class Directory < ActiveRecord::Base
  has_many :photos

  def got_ready_for_detail
    self.is_ready_for_detail = true
    save!
  end
end
