class TargetGroupRepository
  def klass
    TargetGroup
  end

  def all_for_country(country)
    klass.joins(:countries).where('countries_target_groups.country_id = ?', country.id)
  end
end
