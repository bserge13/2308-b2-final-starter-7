require "rails_helper"

RSpec.describe BulkDiscount do 
  describe "validations" do 
    it { should validate_presence_of :name }
    it { should validate_presence_of :threshold }
    it { should validate_presence_of :percentage }
    it { should validate_numericality_of :threshold }
    it { should validate_numericality_of :percentage }
  end

  describe "relationships" do 
    it { should belong_to :merchant }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoice_items).through(:merchant) }
    it { should have_many(:invoices).through(:merchant) }
  end
end