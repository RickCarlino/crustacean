class UsersController < ApplicationController
  def create
    respond_with User.create
  end
end
