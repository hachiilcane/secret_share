class Basket < ActiveRecord::Base
  has_many :pickings
  has_many :photos, :through => :pickings
  attr_accessible :name
end
