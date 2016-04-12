class V1::PrivateApi::TargetEvaluationsController < ApplicationController
  before_filter :authenticate, :require_params

  def create
  	if country
      render json: { price: price(country) }
    else
      render json: { message: 'Country not found' }, status: :not_found
    end
  end

  private

  def price(country)
    klass = country.panel_provider.code.constantize.new
    klass.price
  end

  def country
    CountryRepository.new.find_by_country_code(evaluation_params[:country_code])
  end

  def require_params
    params.require(:country_code)
    params.require(:target_group_id)
    params.require(:locations)
  end

  def evaluation_params
    params.permit(:country_code, :target_group_id, locations: [:id, :panel_size])
  end
end
