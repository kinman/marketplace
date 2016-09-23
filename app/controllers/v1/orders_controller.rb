class V1::OrdersController < ApplicationController

  before_filter :verify_customer

  def index
    @orders = Order.all
  end

  def show
    @order = @customer.orders.find_by_id(params[:id])

    render(nothing: true, status: 404) unless @order
  end

  def create
    @order = @customer.orders.create(params.permit(:item_name))

    if @order.new_record?
      render(json: {error_messages: @order.errors.full_messages}, status: 422) and return
    end

    render(nothing: true, status: 201)
  end

  def update
    render(json: {error_messages: ["orders cannot be modified"]}, status: 403)
  end

  def destroy
    order = @customer.orders.find_by_id(params[:id])

    render(nothing: true, status: 404) and return unless order

    order.destroy

    render(nothing: true, status: 204)
  end

  def verify_customer
    # in the real world, customer would be identified by API key or token,
    # and client wouldn't be expected or allowed to set customer_ids on orders.
    @customer = Customer.find(params[:customer_id])
  end

end