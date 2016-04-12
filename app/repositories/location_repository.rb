class LocationRepository
  def all_for_country(country)
    location_groups = LocationGroup.where(country: country)
    location_groups.map(&:locations).flatten.uniq
  end
end
