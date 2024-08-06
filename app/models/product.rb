class Product < ApplicationRecord
	has_many :orders

	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validate :validate_price
	validates :description, presence: true, length: { in:5...20 }
	
	def validate_price
		if price.nil? || price.negative?
		errors.add(:price, "Price must be greater than 0")
		end
	end
end
