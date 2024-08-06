class Order < ApplicationRecord
  belongs_to :product

  before_validation :calculate_total_price

  private

  def calculate_total_price
    self.total_price = product.price * amount
  end
end