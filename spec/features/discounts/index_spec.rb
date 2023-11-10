require "rails_helper"

RSpec.describe "merchant discounts" do
  before :each do 
    @merchant1 = Merchant.create!(name: "Hair Care")
  
    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
  
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    
    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 2)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 2)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)

    @discount1 = BulkDiscount.create!(name: "10 or more", threshold: 10, percentage: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(name: "15 or more", threshold: 15, percentage: 15, merchant_id: @merchant1.id)
  end 

  it "has a discount index page with links to discounts show pages" do 
    visit "/merchants/#{@merchant1.id}/discounts"

    expect(page).to have_content("#{@merchant1.name} Discounts Index Page")
    expect(page).to have_link(@discount1.name)
    expect(page).to have_link(@discount2.name)

    click_link(@discount2.name)
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount2.id}")
    # save_and_open_page
  end
end