class CountryRepository
  def klass
    Country
  end

  def find_by_country_code(country_code)
    klass.find_by_country_code(country_code)
  end
end