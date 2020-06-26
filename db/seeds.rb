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
  project = Project.create(name: Faker::Company.name,
                           description: Faker::Company.catch_phrase,
                           scope: project_scope,
                           industry: project_scope == "personal" ? nil : Faker::Company.industry,
                           stage: project_scope == "personal" ? nil : Faker::Company.type,
                           country: project_scope == "personal" ? nil : Faker::Nation.nationality)

  # Setup financial settings...


  # Assign users...
  users = User.active.sample(4)
  owner = users[0]
  ProjectUser.create(project: project, user: owner, role: "owner")
  ProjectUser.create(project: project, user: users[1], role: "admin", inviter_id: owner.id)
  ProjectUser.create(project: project, user: users[2], role: "editor", inviter_id: owner.id)
  ProjectUser.create(project: project, user: users[3], role: "viewer", inviter_id: owner.id)
end

puts "Creating portfolios for each user and sharing them..."
User.each do |user|
  2.times do
    # Create portfolio...
    project_count = user.active_projects.count
    portfolio = Portfolio.create(name: ,
                                 description: )

    # Assign users...
    other_user = User.active.reject { |u| u == user }.sample
    PortfolioUser.create(portfolio: portfolio, user: user, role: "owner")
    PortfolioUser.create(portfolio: portfolio, user: other_user, role: ["admin", "editor", "viewer"].sample, inviter_id: user.id)

    # Assigning projects...

  end
end



puts "All set!"
puts ""
puts "*****"
puts "Users: #{User.count}"
puts "Projects: #{Project.count}"
puts "ProjectUsers: #{ProjectUser.count}"
puts "*****"
