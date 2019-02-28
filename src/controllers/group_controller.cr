class GroupController < ApplicationController
  getter group = Group.new

  before_action do
    only [:show, :edit, :update, :destroy] { set_group }
  end

  def index
    groups = Group.all
    render "index.slang"
  end

  def show
    render "show.slang"
  end

  def new
    render "new.slang"
  end

  def edit
    render "edit.slang"
  end

  def create
    group = Group.new group_params.validate!
    if group.save
      redirect_to action: :index, flash: {"success" => "Created group successfully."}
    else
      flash["danger"] = "Could not create Group!"
      render "new.slang"
    end
  end

  def update
    group.set_attributes group_params.validate!
    if group.save
      redirect_to action: :index, flash: {"success" => "Updated group successfully."}
    else
      flash["danger"] = "Could not update Group!"
      render "edit.slang"
    end
  end

  def destroy
    group.destroy
    redirect_to action: :index, flash: {"success" => "Deleted group successfully."}
  end

  private def group_params
    params.validation do
      required :name
      required :external_id
    end
  end

  private def set_group
    @group = Group.find! params[:id]
  end
end
