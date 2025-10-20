class StockItem < ApplicationRecord
  belongs_to :stock
  belongs_to :product
  belongs_to :size

  validates :quantity, presence: true, numericality: true

  delegate :buying_price, to: :size

   # Group stock items by product & size
  def self.grouped_by_product_and_size
    all.includes(:product, :size)
       .group_by { |item| [item.product_id, item.size_id] }
  end

  # Total quantity for a group of stock items
  def self.total_quantity(items)
    items.sum(&:quantity)
  end

  # Total cost for a group of stock items
  def self.total_cost(items)
    total_quantity(items) * items.first.size.buying_price
  end
end
