require "rails_helper"

RSpec.describe "merchant discounts index" do
  before :each do 
    @merchant1 = Merchant.create!(name: "Hair Care")
    @discount1 = BulkDiscount.create!(name: "10 or more", threshold: 10, percentage: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(name: "15 or more", threshold: 15, percentage: 15, merchant_id: @merchant1.id)
    
    visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}/edit"
  end

  it "has a form to edit a discount" do 
    expect(page).to have_content("Edit #{@merchant1.name} discount: #{@discount1.name}")
  end
end 
