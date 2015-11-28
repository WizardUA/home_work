class ItemsController < ApplicationController

  before_filter :find_item, only: [:show, :edit, :update, :destroy, :add_to_cart, :destroy_item_in_cart]
  before_filter :find_cart, only: [:show_cart, :destroy_item_in_cart, :clear_cart, :add_to_cart]
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :check_if_admin, only: [:new, :edit, :create, :update, :destroy, :show_orders, :destroy_order]

  def index
    @items = Item.all
  end

  # /items/1 GET
  def show
  end

  # /items/new GET
  def new
    @item = Item.new
  end

  # /items/1/edit GET
  def edit
  end

  # /items POST
  def create
    @item = Item.create(items_params)
    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render "new"
    end
  end

  # /items/1 PUT
  def update
    @item.update_attributes(items_params)
    if @item.errors.empty?
      flash[:success] = "Item successfully updated!"
      redirect_to item_path(@item)
    else
      flash.now[:error] = "You made mistakes in your form! Please correct them."
      render "edit"
    end
  end

  # /items/1 DELETE
  def destroy
    @item.destroy
    redirect_to action: "index"
  end

# Екшени для роботи з корзиною

  # Добавлення товару в корзину
  def add_to_cart
    if @cart.nil?
      @cart = Cart.create(status: false)
    end
    current_user.carts << @cart
    @position = Position.create(item_id: @item.id, cart_id: @cart.id)
    redirect_to action: "show_cart"
  end

  def show_cart
  end

  # Видалення товару з корзини
  def destroy_item_in_cart
    @position = Position.where("item_id = #{@item.id} AND cart_id = #{@cart.id}").first
    @position.destroy
    redirect_to action: "show_cart"
  end

  # Видалення (корзини) всіх товарів з корзини
  def clear_cart
    @cart.destroy
    redirect_to action: "index"
  end

  # Створення замовлення, зміна атрибуту корзини status в знячення true, створення нової
  # корзини із статусом false і присвоєння її користувачу
  def create_order
    @cart = Cart.where(id: params[:id]).first
    @cart.update_attributes(status: true)
    @cart = Cart.create(status: false)
    current_user.carts << @cart
    redirect_to action: "index"
  end

  def show_orders
    @carts = Cart.where(status: true)
  end

  # Видалення вибранного замовлення
  def destroy_order
    @cart = Cart.where(id: params[:id]).first
    @cart.destroy
    redirect_to action: "show_orders"
  end


  private

  def items_params
    params.require(:item).permit(:name, :price, :description, :item_image)
  end

  def find_cart
    @cart = Cart.where(status: false).where("user_id = #{current_user.id}").first 
  end

  def find_item
    @item = Item.where(id: params[:id]).first
    render_404 unless @item
  end


end
