class Product < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
