require "rails_helper"

RSpec.describe "merchant discounts" do
  before :each do 
    @merchant1 = Merchant.create!(name: "Hair Care")
    @discount1 = BulkDiscount.create!(name: "10 or more", threshold: 10, percentage: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(name: "15 or more", threshold: 15, percentage: 15, merchant_id: @merchant1.id)
  end 

  it "has a discount index page with links to discounts show pages" do 
    visit "/merchants/#{@merchant1.id}/discounts"

    expect(page).to have_content("#{@merchant1.name} Discounts Index Page")
    
    expect(page).to have_link(@discount1.name)
    expect(page).to have_content(@discount1.threshold)
    expect(page).to have_content(@discount1.percentage)
    
    expect(page).to have_link(@discount2.name)
    expect(page).to have_content(@discount2.threshold)
    expect(page).to have_content(@discount2.percentage)

    click_link(@discount2.name)
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount2.id}")
  end
end