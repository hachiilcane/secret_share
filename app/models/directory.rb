class Directory < ActiveRecord::Base
  has_many :photos

  def gotReadyForDetail
    self.is_ready_for_detail = true
    save!
  end
end
