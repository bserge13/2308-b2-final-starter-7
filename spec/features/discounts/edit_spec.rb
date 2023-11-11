require "rails_helper"

RSpec.describe "merchant discounts index" do
  before :each do 
    @merchant1 = Merchant.create!(name: "Hair Care")
    @discount1 = BulkDiscount.create!(name: "10 or more", threshold: 10, percentage: 10, merchant_id: @merchant1.id)    
    visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}/edit"
  end

  it "has a form to edit a discount with a discounts information pre-filled in" do 
    expect(page).to have_content("Edit discount")
    
    expect(page).to have_field("Name", with: @discount1.name)
    expect(page).to have_field("Threshold", with: @discount1.threshold)
    expect(page).to have_field("Percentage", with: @discount1.percentage)
    expect(page).to have_button("Update")
  end

  it "updates a discount and redirects back to show page with updated info" do 
    fill_in "Name", with: "Christmas Special"
    fill_in "Threshold", with: 12 
    fill_in "Percentage", with: 25
    click_button "Update"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount1.id}")
    
    expect(page).to have_content("Christmas Special")
    expect(page).to have_content("12 items")
    expect(page).to have_content("25%")
  end
end 
