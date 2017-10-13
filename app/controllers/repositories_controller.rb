require 'pry'

class RepositoriesController < ApplicationController
  def index
    @user = session[:username]

    resp = Faraday.get "https://api.github.com/users/#{@user}/repos"
    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    
    redirect_to root_path

  end
end
