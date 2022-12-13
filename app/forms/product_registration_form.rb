class ProductRegistrationForm
  include ActiveModel::Model
  DEFAULT_ITEM_COUNT = 5
  attr_accessor :products
  validate :check_code_unique
  
  def initialize(attributes = {})
    super attributes
    self.products = DEFAULT_ITEM_COUNT.times.map { Forms::Product.new } unless products.present?
  end

  def products_attributes=(attributes)
    self.products = attributes.map do |_, product_attributes|
      Forms::Product.new(product_attributes)
    end
  end

  def valid?
    unless target_products.map(&:save!).all?
      target_products.flat_map { |p| p.errors.full_messages }.uniq.each do |message|
        errors.add(:base, message)
      end
    end
    errors.blank?
  end

  def save
    return false unless valid?
    Product.transaction {
      target_products.each(&:save!)
    }
    true
  end

  def target_products
    debugger
    self.products.select {
      |v| ActiveRecord::Type::Boolean.new.cast(v.register)
      
    }
  end

  def check_code_unique
    errors.add(:base, '商品コードが重複しています') if target_products.pluck(:code).count - target_products.pluck(:code).uniq.count > 0
  end
end