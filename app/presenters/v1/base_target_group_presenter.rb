class V1::BaseTargetGroupPresenter
  def initialize(target_group)
    @resource = target_group
  end

  def tree
    result = {
      id: @resource.id,
      name: @resource.name,
      external_id: @resource.external_id,
    }
    if @resource.panel_provider_id
      result[:panel_provider_id] = @resource.panel_provider_id
    end
    if @resource.children.present?
      result[:children] = @resource.children.map { |node| self.class.new(node).tree }
    end
    result
  end
end
