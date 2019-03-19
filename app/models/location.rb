class Location < ApplicationRecord
  has_many :shared_locations

  validates :latitude, :longitude, presence: true
end
