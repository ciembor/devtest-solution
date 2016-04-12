class V1::PrivateApi::LocationsController < V1::BaseLocationsController
  before_filter :authenticate

  private

  def presenter_class
    V1::PrivateApi::LocationPresenter
  end
end
