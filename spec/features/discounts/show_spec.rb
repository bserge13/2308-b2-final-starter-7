require "rails_helper"

RSpec.describe "merchant discounts show" do
  before :each do 
    @merchant1 = Merchant.create!(name: "Hair Care")
    @discount1 = BulkDiscount.create!(name: "10 or more", threshold: 10, percentage: 10, merchant_id: @merchant1.id)

    visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}"
  end

  it "has a discount show page for a specific discount" do 
    expect(page).to have_content("#{@merchant1.name} Discount Show Page- #{@discount1.name}")
    expect(page).to have_content(@discount1.name)
    expect(page).to have_content(@discount1.threshold)
    expect(page).to have_content(@discount1.percentage)
  end
end 

