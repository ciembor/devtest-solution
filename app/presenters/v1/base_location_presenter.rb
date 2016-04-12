class V1::BaseLocationPresenter
  def initialize(location)
    @resource = location
  end

  def as_json
    {
      id: @resource.id,
      name: @resource.name,
      external_id: @resource.external_id
    }
  end
end
