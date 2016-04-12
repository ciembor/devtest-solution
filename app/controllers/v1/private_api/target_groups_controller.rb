class V1::PrivateApi::TargetGroupsController < V1::BaseTargetGroupsController
  before_filter :authenticate

  private

  def presenter_class
    V1::PrivateApi::TargetGroupPresenter
  end
end
