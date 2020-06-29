class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :project_users
  has_many :project_invites, class_name: "ProjectUser", foreign_key: :inviter_id
  has_many :projects, through: :project_users

  has_many :portfolio_users
  has_many :portfolio_invites, class_name: "PortfolioUser", foreign_key: :inviter_id
  has_many :portfolios, through: :portfolio_users

  scope :active, -> { where(status: 'active') }

  # Get only active projects
  def active_projects
    project_users.active.joins(:project).where('projects.status = ?', "active")
  end
end
