class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(items_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def items_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id, :shipping_fee_burden_id,
      :prefecture_id, :shipping_days_id, :price, :image
    ).merge(user_id: current_user.id)
  end
end
