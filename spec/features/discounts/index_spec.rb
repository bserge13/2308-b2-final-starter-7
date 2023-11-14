require "rails_helper"

RSpec.describe "merchant discounts index" do
  before :each do 
    @merchant1 = Merchant.create!(name: "Hair Care")
    @discount1 = BulkDiscount.create!(name: "10 or more", threshold: 10, percentage: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(name: "15 or more", threshold: 15, percentage: 15, merchant_id: @merchant1.id)
    
    visit "/merchants/#{@merchant1.id}/discounts"
  end 

  it "has a discount index page with links to discounts show pages" do 
    expect(page).to have_content("#{@merchant1.name} Discounts Index Page")
    
    within "#discount-#{@discount1.id}" do 
      expect(page).to have_link(@discount1.name)
      expect(page).to have_content(@discount1.threshold)
      expect(page).to have_content(@discount1.percentage)
    end 

    within "#discount-#{@discount2.id}" do 
      expect(page).to have_link(@discount2.name)
      expect(page).to have_content(@discount2.threshold)
      expect(page).to have_content(@discount2.percentage)
      click_link(@discount2.name)
      expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount2.id}")
    end
  end

  it "has a link to create new discounts" do 
    expect(page).to have_link("Create new discount")
    click_link("Create new discount")
    expect(current_path).to eq(new_merchant_discount_path(@merchant1))
  end

  it "has a button to delete a discount" do 
    within "#discount-#{@discount1.id}" do 
      expect(page).to have_button("Delete discount")
    end
  end

  it "deletes a discount from a merchants discount index page" do 
    within "#discount-#{@discount1.id}" do 
      click_button("Delete discount")
      expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts")
    end

    expect(page).to_not have_content(@discount1)
  end

  it "redirects a user to a discounts show page" do 
    click_link(@discount1.name)
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount1.id}")
  end
end