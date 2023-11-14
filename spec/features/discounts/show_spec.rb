require "rails_helper"

RSpec.describe "merchant discounts show" do
  before :each do 
    @merchant1 = Merchant.create!(name: "Hair Care")
    @discount1 = BulkDiscount.create!(name: "10 or more", threshold: 10, percentage: 10, merchant_id: @merchant1.id)

    visit merchant_discount_path(@merchant1, @discount1)
  end

  it "has a discount show page for a specific discount" do 
    expect(page).to have_content("#{@merchant1.name} Discount Show Page- #{@discount1.name}")
    expect(page).to have_content(@discount1.name)
    expect(page).to have_content(@discount1.threshold)
    expect(page).to have_content(@discount1.percentage)
  end

  it "has a link to edit a discount" do 
    expect(page).to have_link("Edit discount")
  end

  it "redirects a user to an edit page where a discount can be updated" do 
    click_link("Edit discount")
    expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))
  end
end 

