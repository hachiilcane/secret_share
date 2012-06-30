class Picking < ActiveRecord::Base
  belongs_to :photo
  belongs_to :basket
end
