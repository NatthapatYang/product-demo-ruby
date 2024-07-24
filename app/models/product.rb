class Product < ApplicationRecord
    validates :name, presence: true
    validate :validate_price
    validates :description, presence: true


    def validate_price
		if price.nil? || price.negative?
			errors.add(:price, "Price must be greater than 0")
		end
    end
end
