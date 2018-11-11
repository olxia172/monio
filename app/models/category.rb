class Category < ApplicationRecord
  has_many :operations
  belongs_to :expense, optional: true

  validates :name, presence: true, uniqueness: true
end
