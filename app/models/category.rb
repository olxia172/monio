class Category < ApplicationRecord
  has_many :operations
  belongs_to :setting, optional: true

  validates :name, presence: true, uniqueness: true
end
