class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :accounts, dependent: :nullify
  has_many :operations, dependent: :nullify
  has_many :template_operations, dependent: :nullify
end
