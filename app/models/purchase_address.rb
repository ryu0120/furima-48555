class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :city, :address, :user_id, :item_id, :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :phone_number,
              length: { minimum: 10, message: 'is too short' },
              format: { with: /\A[0-9]{10,11}\z/ }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)

    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building,
                   phone_number: phone_number, purchase_id: purchase.id)
  end
end
