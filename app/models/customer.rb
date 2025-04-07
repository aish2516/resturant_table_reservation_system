class Customer < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates :name, :email, :phone, presence: true

end
