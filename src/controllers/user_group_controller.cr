class UserGroupController < ApplicationController
  getter user_group = UserGroup.new

  before_action do
    only [:show, :edit, :update, :destroy] { set_user_group }
  end

  def index
    user_groups = UserGroup.all
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
    user_group = UserGroup.new user_group_params.validate!
    if user_group.save
      redirect_to action: :index, flash: {"success" => "Created user_group successfully."}
    else
      flash["danger"] = "Could not create UserGroup!"
      render "new.slang"
    end
  end

  def update
    user_group.set_attributes user_group_params.validate!
    if user_group.save
      redirect_to action: :index, flash: {"success" => "Updated user_group successfully."}
    else
      flash["danger"] = "Could not update UserGroup!"
      render "edit.slang"
    end
  end

  def destroy
    user_group.destroy
    redirect_to action: :index, flash: {"success" => "Deleted user_group successfully."}
  end

  private def user_group_params
    params.validation do
      required :user_id
      required :group_id
    end
  end

  private def set_user_group
    @user_group = UserGroup.find! params[:id]
  end
end
