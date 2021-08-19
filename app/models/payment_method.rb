class PaymentMethod < ApplicationRecord
  has_many :payments, dependent: :destroy
end
