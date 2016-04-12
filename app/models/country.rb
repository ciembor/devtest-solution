class Country < ActiveRecord::Base
  has_many :location_groups
  has_and_belongs_to_many :target_groups, -> { roots }
  belongs_to :panel_provider
end
