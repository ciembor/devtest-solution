class V1::PrivateApi::TargetGroupPresenter < V1::BaseTargetGroupPresenter
  def tree
    super.merge({
      secret_code: @resource.secret_code
    })
  end
end
