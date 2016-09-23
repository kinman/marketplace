class V1::CustomersController < ApplicationController
  
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def create
    customer = Customer.create(params.permit(:name))

    if customer.new_record?
      render(json: {error_messages: customer.errors.full_messages}, status: 422)
    else
      render(nothing: true, status: 201)
    end
  end

  def update
    @customer = Customer.find(params[:id])

    attributes = params.permit(:name)

    unless @customer.update_attributes(attributes)
      render(json: {error_messages: @customer.errors.full_messages}, status: 422) and return
    end

    render "show"
  end

  def destroy
    customer = Customer.find(params[:id])

    if customer.orders.any?
      render(json: {error_messages: ["Customer has placed orders, cannot be deleted."]}, status: 422) and return
    end

    customer.destroy

    render(nothing: true, status: 204)
  end
end