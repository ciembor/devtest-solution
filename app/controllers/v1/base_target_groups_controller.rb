class V1::BaseTargetGroupsController < ApplicationController
  def index
    if country
      render json: presented_target_groups(country)
    else
      render json: { message: 'Country not found' }, status: :not_found
    end
  end

  protected

  def presenter_class
    fail NotImplementedError, 'abstract'
  end

  def presented_target_groups(country)
    target_groups(country).map do |target_group|
      presenter_class.new(target_group).tree
    end
  end

  def target_groups(country)
    TargetGroupRepository.new.all_for_country(country)
  end

  def country
    CountryRepository.new.find_by_country_code(params[:country_code])
  end
end
