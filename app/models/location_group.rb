class LocationGroup < ActiveRecord::Base
  belongs_to :country
  has_and_belongs_to_many :locations
  belongs_to :panel_provider
end
