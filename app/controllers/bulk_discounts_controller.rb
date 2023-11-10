class BulkDiscountsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
  end

  def show

  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create 
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.new(discount_params)
    if discount.save 
      redirect_to "/merchants/#{merchant.id}/discounts"
    else 
      flash[:error] = "Error: All fields must be filled in to submit"
      redirect_to "/merchants/#{merchant.id}/discounts/new"
    end
  end

  private 

  def discount_params 
    params.permit(:name, :threshold, :percentage)
  end
end