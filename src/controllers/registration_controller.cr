class RegistrationController < ApplicationController
  def new
    user = User.new(email: params[:email], external_id: params[:external_id])
    render("new.slang")
  end

  def create
    user = User.new(registration_params.validate!)
    user.password = params["password"].to_s

    if user.valid? && user.save
      session[:user_id] = user.id
      flash["success"] = "Created User successfully."
      redirect_to "/"
    else
      flash["danger"] = "Could not create User!"
      render("new.slang")
    end
  end

  private def registration_params
    params.validation do
      required(:email) { |f| !f.nil? }
      required(:external_id) { |f| !f.nil? }
      required(:password) { |f| !f.nil? }
    end
  end
end
