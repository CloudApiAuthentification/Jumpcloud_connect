class SessionController < ApplicationController
  def new
    user = User.new
    render("new.slang")
  end

  def new_email
    user = User.new email: params[:email]
    render("new_email.slang")
  end

  def post_new_email
    exist = User.where(email: params[:email])

    pp exist.count

    if(exist.count > 0)
      pp exist
      # Redirect to Signin
    else
      if false # Jumpcloud
        # Redirect to Signup
      else
        raise "Connard"
      end
    end

    "Coucou"
  end

  def create
    user = User.find_by(email: params["email"].to_s)
    if user && user.authenticate(params["password"].to_s)
      session[:user_id] = user.id
      flash[:info] = "Successfully logged in"
      redirect_to "/"
    else
      flash[:danger] = "Invalid email or password"
      user = User.new
      render("new.slang")
    end
  end

  def delete
    session.delete(:user_id)
    flash[:info] = "Logged out. See ya later!"
    redirect_to "/"
  end
end
