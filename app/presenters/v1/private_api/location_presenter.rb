class V1::PrivateApi::LocationPresenter < V1::BaseLocationPresenter
  def as_json
  	super.merge({
      secret_code: @resource.secret_code
  	})
  end
end
