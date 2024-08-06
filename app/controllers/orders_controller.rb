class OrdersController < ApplicationController
  def create
    @product = Product.find(params[:order][:product_id])
    @amount = params[:order][:amount].to_i

    @order = Order.new(product: @product, amount: @amount)

    if @order.save
      redirect_to @order
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
