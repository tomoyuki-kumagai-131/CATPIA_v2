class Shop < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 150 }
  validates :address, presence: true, length: { maximum: 50 }
  validates :recommended_points, length: { maximum: 50 }
  validates :rating,
            :numericality => {
              :only_interger => true,
              :greater_than_or_equal_to => 1,
              :less_than_or_equal_to => 5
            },
            allow_nil: true
end
