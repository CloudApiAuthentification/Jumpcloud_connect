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

    pp "exist ? #{exist.count}"

    if exist.count > 0
      redirect_to(location: "/signin/#{params[:email]}")
    else
      headers = HTTP::Headers{ "x-api-key" => "ae65506bafe3e3c8a0e4c8e0fe2cb4599a952839" }
      body = %Q({"filter": [{"email": "#{params[:email]}"}]})
      response = HTTP::Client.post("https://console.jumpcloud.com/api/search/systemusers", headers: headers, body: body)
      res_body = JSON.parse(response.body)
      pp res_body
      pp params[:email]
      if res_body["totalCount"].as_i > 0
        # Redirect to Signup
        redirect_to(location: "/signup/#{params[:email]}?external_id=#{res_body["results"][0]["_id"]}")
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
