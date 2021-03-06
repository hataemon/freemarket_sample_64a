class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order("created_at DESC").with_attached_images.limit(10)
  end

  def show
  end

  def sell
    @item = Item.new
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: '商品を編集しました'
    else
      render :edit
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :sell
    end
  end

  def destroy
    if@item.destroy
      redirect_to items_url, notice: '商品を削除しました'
    else
      render
    end
  end

  private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(
        :item_name,
        :explain,
        :category,
        :size,
        :brand,
        :condition,
        :postage,
        :shipping_method,
        :prefecture_id,
        :shipping_days,
        :price,
        :trade_state,
        images: []
      ).merge(user_id: current_user.id)
    end
end
