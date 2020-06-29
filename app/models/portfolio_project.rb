class PortfolioProject < ApplicationRecord
  belongs_to :portfolio
  belongs_to :project

  scope :active, -> { where(status: 'active') }
end
