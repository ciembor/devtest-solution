class TargetGroup < ActiveRecord::Base
  has_and_belongs_to_many :countries
  belongs_to :parent, class_name: 'TargetGroup'
  has_many :children, class_name: 'TargetGroup', foreign_key: 'parent_id'
  belongs_to :panel_provider
  scope :roots, -> { where('parent_id IS NULL') }
end
