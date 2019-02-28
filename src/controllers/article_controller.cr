class GroupSynchro
  def initialize
    @headers = HTTP::Headers{ "x-api-key" => "ae65506bafe3e3c8a0e4c8e0fe2cb4599a952839" }
  end

  # Ugly method
  def call(user : User)
    uri = "https://console.jumpcloud.com/api/v2/users/#{user.external_id}/memberof"
    response = HTTP::Client.get(uri, headers: @headers)
    res_body = JSON.parse(response.body)

    ext_groups = res_body.as_a.map do |ext| 
      { 
        id: ext["id"].as_s, 
        name: ext["compiledAttributes"]["ldapGroups"][0]["name"].as_s 
      }
    end

    groups = Group.all

    new_groups = ext_groups.reject { |g| groups.map(&.external_id).includes?(g[:id]) }
                           .map { |g| Group.new(name: g[:name], external_id: g[:id]) }

    Group.import(new_groups)

    # Group.all("WHERE external_id in (?)", [ext_groups.map { |g| g[:id] }.join(", ")])
    Group.where(:external_id, :in, ext_groups.map { |g| g[:id] }.join(", "))

    ids = ext_groups.map { |g| g[:id] }
                    .map { |g| "'#{g}'" }
                    .join(", ")
    Group.raw_all("WHERE external_id IN (#{ids})")
  end
end

class ArticleController < ApplicationController
  getter article = Article.new

  before_action do
    only [:show, :edit, :update, :destroy] { set_article }
  end

  def index
    synchro = GroupSynchro.new
    groups = synchro.call(current_user.not_nil!)

    pp groups

    # articles = Article.all("WHERE group_id in (?)", groups.map(&.id).join(", "))
    ids = groups.map { |g| g.id }
                .map { |g| "'#{g}'"}
                .join(", ")
    articles = Article.raw_all("WHERE group_id IN (#{ids})")
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
    article = Article.new article_params.validate!
    if article.save
      redirect_to action: :index, flash: {"success" => "Created article successfully."}
    else
      flash["danger"] = "Could not create Article!"
      render "new.slang"
    end
  end

  def update
    article.set_attributes article_params.validate!
    if article.save
      redirect_to action: :index, flash: {"success" => "Updated article successfully."}
    else
      flash["danger"] = "Could not update Article!"
      render "edit.slang"
    end
  end

  def destroy
    article.destroy
    redirect_to action: :index, flash: {"success" => "Deleted article successfully."}
  end

  private def article_params
    params.validation do
      required :body
      required :group_id
    end
  end

  private def set_article
    @article = Article.find! params[:id]
  end
end
