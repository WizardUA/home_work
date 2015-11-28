class CartsController < ApplicationController

  def index
    
  end

  # /items/1 GET
  def show
    @item = Item.where(id: params[:id]).first
  end

  # /items/new GET
  def new
    @item = Item.where(id: params[:format]).first
    @position = Position.new
  end

  # /items/1/edit GET
  def edit

  end

  # /items POST
  def create
    
  end

  # /items/1 PUT
  def update
    
  end

  # /items/1 DELETE
  def destroy
    
  end

end
