require "./spec_helper"

def user_group_hash
  {"user_id" => "1", "group_id" => "1"}
end

def user_group_params
  params = [] of String
  params << "user_id=#{user_group_hash["user_id"]}"
  params << "group_id=#{user_group_hash["group_id"]}"
  params.join("&")
end

def create_user_group
  model = UserGroup.new(user_group_hash)
  model.save
  model
end

class UserGroupControllerTest < GarnetSpec::Controller::Test
  getter handler : Amber::Pipe::Pipeline

  def initialize
    @handler = Amber::Pipe::Pipeline.new
    @handler.build :web do
      plug Amber::Pipe::Error.new
      plug Amber::Pipe::Session.new
      plug Amber::Pipe::Flash.new
    end
    @handler.prepare_pipelines
  end
end

describe UserGroupControllerTest do
  subject = UserGroupControllerTest.new

  it "renders user_group index template" do
    UserGroup.clear
    response = subject.get "/user_groups"

    response.status_code.should eq(200)
    response.body.should contain("user_groups")
  end

  it "renders user_group show template" do
    UserGroup.clear
    model = create_user_group
    location = "/user_groups/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show User Group")
  end

  it "renders user_group new template" do
    UserGroup.clear
    location = "/user_groups/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New User Group")
  end

  it "renders user_group edit template" do
    UserGroup.clear
    model = create_user_group
    location = "/user_groups/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit User Group")
  end

  it "creates a user_group" do
    UserGroup.clear
    response = subject.post "/user_groups", body: user_group_params

    response.headers["Location"].should eq "/user_groups"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a user_group" do
    UserGroup.clear
    model = create_user_group
    response = subject.patch "/user_groups/#{model.id}", body: user_group_params

    response.headers["Location"].should eq "/user_groups"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a user_group" do
    UserGroup.clear
    model = create_user_group
    response = subject.delete "/user_groups/#{model.id}"

    response.headers["Location"].should eq "/user_groups"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
