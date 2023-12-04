require 'rails_helper'

#Demonstrates
## A user can not have multiple projects with the same name
## One project can be assigned to multiple users

#This tests validations: 
# app/models/project.rb
# validates :name, presence: true, uniqueness: { scope: :user_id }

RSpec.describe Project, type: :model do

  #Assign duplicate projects to the same user
  it "does not allow duplicate project names per user" do
    #Persists a user
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    #Persists a user project
    user.projects.create(
      name: "Test Project",
    )

    #Attempts to create a new user project with name that already exists
    new_project = user.projects.build(
      name: "Test Project",
    )


    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  #Assign the same project name to two users.
  it "allows two users to share a project name" do

    #Persist user
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    #Persist project
    user.projects.create(
      name: "Test Project",
    )

    #Persist second user
    other_user = User.create(
      first_name: "Jane",
      last_name: "Tester",
      email: "janetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    #Build project in second user
    other_project = other_user.projects.build(
      name: "Test Project",
    )

    expect(other_project).to be_valid
  end
end