class V1::BaseLocationsController < ApplicationController
  def index
    if country
      render json: presented_locations(country)
    else
      render json: { message: 'Country not found' }, status: :not_found
    end
  end

  protected

  def presenter_class
    fail NotImplementedError, 'abstract'
  end

  def presented_locations(country)
    locations(country).map { |location| presenter_class.new(location).as_json }
  end

  def locations(country)
    LocationRepository.new.all_for_country(country)
  end

  def country
    CountryRepository.new.find_by_country_code(params[:country_code])
  end
end