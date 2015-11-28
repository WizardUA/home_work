class PersonsController < ApplicationController

  before_filter :find_user,      only: [:show, :destroy]
  before_filter :check_if_admin, only: [:index, :show, :destroy]
  before_filter :authenticate_user!


  def index
    @users = User.all
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to action: "index"
  end

  def profile
  end


  private

  def find_user
    @user = User.where(id: params[:id]).first
  end

end
