class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :template_operation
end
