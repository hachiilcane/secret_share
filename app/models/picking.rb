class Picking < ActiveRecord::Base
  belongs_to :photo
  belongs_to :basket
  attr_accessible :photo_id, :basket_id
end
