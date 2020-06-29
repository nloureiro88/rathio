require 'csv'

puts "Destroying all previous data..."

Portfolio.destroy_all
Project.destroy_all
User.destroy_all

puts "Creating users..."
20.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(first_name: first_name,
              last_name: last_name,
              email: Faker::Internet.free_email(name: first_name + last_name),
              password: "123456")
end

puts "Creating projects and assignating users..."
50.times do
  # Create project...
  project_scope = ["business", "personal"].sample
  start_date = Time.now + rand(1..6).month
  project = Project.create(name: Faker::Company.name,
                           description: Faker::Company.catch_phrase,
                           start_date: start_date,
                           end_date: (start_date + rand(1..5).years).end_of_year,
                           scope: project_scope,
                           industry: project_scope == "personal" ? nil : Faker::Company.industry,
                           stage: project_scope == "personal" ? nil : Faker::Company.type,
                           country: project_scope == "personal" ? nil : Faker::Nation.nationality)

  # Assign users...
  users = User.active.sample(4)
  owner = users[0]
  ProjectUser.create(project: project, user: owner, role: "owner")
  ProjectUser.create(project: project, user: users[1], role: "admin", inviter_id: owner.id)
  ProjectUser.create(project: project, user: users[2], role: "editor", inviter_id: owner.id)
  ProjectUser.create(project: project, user: users[3], role: "viewer", inviter_id: owner.id)
end

puts "Creating portfolios for each user and sharing them..."
User.all.each do |user|
  2.times do
    # Create portfolio...
    project_count = user.active_projects.count
    portfolio = Portfolio.create(name: Faker::TvShows::SiliconValley.company,
                                 description: Faker::TvShows::SiliconValley.quote)

    # Assign users...
    other_user = User.active.reject { |u| u == user }.sample
    PortfolioUser.create(portfolio: portfolio, user: user, role: "owner")
    PortfolioUser.create(portfolio: portfolio, user: other_user, role: ["admin", "editor", "viewer"].sample, inviter_id: user.id)

    # Assigning projects...
    user_projects = user.projects
    selected_projects = user_projects.sample(rand(2..user_projects.size))
    selected_projects.each { |project| PortfolioProject.create(portfolio: portfolio, project: project) }
  end
end



puts "All set!"
puts ""
puts "*****"
puts "Users: #{User.count}"
puts "-----"
puts "Projects: #{Project.count}"
puts "ProjectUsers: #{ProjectUser.count}"
puts "-----"
puts "Portfolios: #{Portfolio.count}"
puts "PortfolioUsers: #{PortfolioUser.count}"
puts "PortfolioProjects: #{PortfolioProject.count}"
puts "-----"
puts "*****"
