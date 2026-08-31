class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :city, :address, :user_id, :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :phone_number,
            presence: true,
            format: { with: /\A[0-9]{10,11}\z/ }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)

    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building,
                   phone_number: phone_number, purchase_id: purchase.id)
  end
end
