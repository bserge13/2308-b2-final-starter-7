class BulkDiscountsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id]) 
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create 
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.new(discount_params)
    if discount.save 
      redirect_to merchant_discounts_path(merchant)
    else 
      flash[:error] = "Error: All fields must be filled in to submit"
      redirect_to new_merchant_discount_path(merchant)
    end
  end

  def destroy 
    merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:id])
    
    discount.destroy
    redirect_to merchant_discounts_path(merchant)
  end

  def edit 
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id]) 
  end

  def update 
    merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:id])

    discount.update(discount_params)
    redirect_to merchant_discount_path(merchant, discount)
  end

  private 

  def discount_params 
    params.permit(:name, :threshold, :percentage)
  end
end