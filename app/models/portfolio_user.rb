class PortfolioUser < ApplicationRecord
  belongs_to :portfolio
  belongs_to :user
  belongs_to :inviter, class_name: "User", optional: true

  scope :active, -> { where(status: 'active') }
end
