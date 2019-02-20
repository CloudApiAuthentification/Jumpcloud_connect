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

    pp "Is exist"
    pp exist.count

    if exist.count > 0
      pp exist
      redirect_to(location: "/signin/#{params[:email]}")
    else
      pp params[:email]
      pp headers = HTTP::Headers{ "x-api-key" => "ae65506bafe3e3c8a0e4c8e0fe2cb4599a952839" }
      pp body = %Q({"filter": [{"email": "#{params[:email]}"}]})
      pp response = HTTP::Client.post("https://console.jumpcloud.com/api/search/systemusers", headers: headers, body: body)
      pp res_body = JSON.parse(response.body)
      if res_body["totalCount"].as_i > 0
        # Redirect to Signup
        redirect_to(location: "/signup/#{params[:email]}")
      else
        flash[:notice] = "You don't have any account."
        redirect_to(location: "/")
      end
    end
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
