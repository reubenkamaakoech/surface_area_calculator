class Product < ApplicationRecord
    belongs_to :user
    has_many :sizes, dependent: :destroy
    has_many :stock_items
end
