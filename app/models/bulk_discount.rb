class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :merchant
  has_many :invoices, through: :merchant

  validates :name, presence: true 
  validates :threshold, presence: true, numericality: true  
  validates :percentage, presence: true, numericality: true  
end