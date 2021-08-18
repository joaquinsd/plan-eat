class Order < ApplicationRecord
  belongs_to :user
  before_create -> { generate_number(hash_size) }
  validates :number, uniqueness: true

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items, dependent: :destroy

  def generate_number(size)
    self.number ||= loop do
      random = random_candidate(size)
      break random unless self.class.exists?(number: random)
    end
  end

  def random_candidate(size)
    "#{hash_prefix}#{Array.new(size){rand(size)}.join}"
  end

  def hash_prefix
    "BO-"
  end

  def hash_size
    9
  end

  def add_product(product_id, quantity)
    product = Product.find(product_id)
    if product && product.stock.positive?
      order_items.create(product_id: product.id, quantity: quantity, price: product.price)
    end
  end
end
