class Product < ActiveRecord::Base
  has_many :productimages
  accepts_nested_attributes_for :productimages, allow_destroy: true
  belongs_to :user
  has_one :map
  accepts_nested_attributes_for :map
  has_many :reviews

  validates_presence_of :title, :destination, :departure, :arrival
end
