class V1::PublicApi::TargetGroupsController < V1::BaseTargetGroupsController
  private

  def presenter_class
    V1::PublicApi::TargetGroupPresenter
  end
end