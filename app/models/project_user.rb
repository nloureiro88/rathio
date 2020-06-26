class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :inviter, class_name: "User", optional: true

  scope :active, -> { where(status: 'active') }
end
