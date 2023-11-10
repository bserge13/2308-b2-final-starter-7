require "rails_helper"

RSpec.describe "merchant discounts" do
  before :each do 
    @merchant1 = Merchant.create!(name: "Hair Care")
    @discount1 = BulkDiscount.create!(name: "10 or more", threshold: 10, percentage: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(name: "15 or more", threshold: 15, percentage: 15, merchant_id: @merchant1.id)
    
    visit "/merchants/#{@merchant1.id}/discounts"
  end 

  it "has a discount index page with links to discounts show pages" do 
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

  it "has a link to create new discounts" do 
    expect(page).to have_link("Create new discount")
  end

  it "has a form to create a new discount on a new discount page" do 
    click_link("Create new discount")
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/new")

    expect(page).to have_content("Create a new discount for #{@merchant1.name}")
    expect(page).to have_field("Name")
    expect(page).to have_field("Threshold")
    expect(page).to have_field("Percentage")
  end

  it "creates a new discount and appears on a merchants' discounts index page" do 
    click_link("Create new discount")
    fill_in "Name", with: "20 or more"
    fill_in "Threshold", with: 20 
    fill_in "Percentage", with: 20
    click_button "Create"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts")
    
    expect(page).to have_link("20 or more")
    expect(page).to have_content("Threshold: 20 items")
    expect(page).to have_content("Percentage: 20%")
  end

  it "flashes an error message when given invalid data for creating" do 
    click_link("Create new discount")
    click_button "Create"
    expect(page).to have_content("Error: All fields must be filled in to submit")
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/new")
  end

  it "has a button to delete  discount" do 
    within "#discount-#{@discount1.id}" do 
      expect(page).to have_button("Delete discount")
    end
  end

  it "deletes a discount from a merchants discount index page" do 
    within "#discount-#{@discount1.id}" do 
      click_button("Delete discount")
    end
    
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts")
    expect(page).to_not have_content(@discount1)
  end
end