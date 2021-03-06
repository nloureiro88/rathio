class Project < ApplicationRecord
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users

  has_many :portfolio_projects
  has_many :portfolios, through: :portfolio_projects

  scope :active, -> { where(status: 'active') }

  ### STATUS MANAGEMENT

  # Inactivate project
  def inactivate
    update(status: "inactivate")
  end

  # Reactivate project
  def reactivate
    update(status: "active")
  end

  ### USER MANAGEMENT

  # Get only active users
  def active_users
    project_users.active.joins(:user).where('users.status = ?', "active")
  end

  # Get owner
  def owner
    pu = project_users.find_by(project: self, role: "owner", status: "active")
    pu.nil? ? nil : pu.user
  end

  # Change owner
  def change_owner(user)
    pu = get_project_user(user)
    return if pu.nil?

    # Change role of existing user
    pu.update(role: "owner")

    # Change past owner to admin only
    current_owner = owner
    current_owner.update(role: "admin")
  end

  # Get role of user (string)
  def role(user)
    pu = get_project_user(user)
    pu.nil? ? nil : pu.role
  end

  # Add user with role
  def add_user(user, role)
    ProjectUser.create(project: self, user: user, role: role)
  end

  # Change user role
  def change_user(user, role)
    pu = get_project_user(user)
    pu.update(role: role)
  end

  # Remove user
  def remove_user(user)
    pu = get_project_user(user)
    pu.update(status: "inactive")
  end

  private

  # Get a project user for a given user
  def get_project_user(user)
    project_users.find_by(project: self, user: user, status: "active")
  end
end
