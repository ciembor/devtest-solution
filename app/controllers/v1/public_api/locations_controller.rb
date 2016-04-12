class V1::PublicApi::LocationsController < V1::BaseLocationsController
  private

  def presenter_class
    V1::PublicApi::LocationPresenter
  end
end