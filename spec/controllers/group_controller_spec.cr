require "./spec_helper"

def group_hash
  {"name" => "Fake", "external_id" => "Fake"}
end

def group_params
  params = [] of String
  params << "name=#{group_hash["name"]}"
  params << "external_id=#{group_hash["external_id"]}"
  params.join("&")
end

def create_group
  model = Group.new(group_hash)
  model.save
  model
end

class GroupControllerTest < GarnetSpec::Controller::Test
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

describe GroupControllerTest do
  subject = GroupControllerTest.new

  it "renders group index template" do
    Group.clear
    response = subject.get "/groups"

    response.status_code.should eq(200)
    response.body.should contain("groups")
  end

  it "renders group show template" do
    Group.clear
    model = create_group
    location = "/groups/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Group")
  end

  it "renders group new template" do
    Group.clear
    location = "/groups/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Group")
  end

  it "renders group edit template" do
    Group.clear
    model = create_group
    location = "/groups/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Group")
  end

  it "creates a group" do
    Group.clear
    response = subject.post "/groups", body: group_params

    response.headers["Location"].should eq "/groups"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a group" do
    Group.clear
    model = create_group
    response = subject.patch "/groups/#{model.id}", body: group_params

    response.headers["Location"].should eq "/groups"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a group" do
    Group.clear
    model = create_group
    response = subject.delete "/groups/#{model.id}"

    response.headers["Location"].should eq "/groups"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
