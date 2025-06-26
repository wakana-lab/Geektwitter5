class Shop < ApplicationRecord
  has_many :comments, dependent: :destroy
end
