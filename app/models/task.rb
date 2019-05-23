class Task < ApplicationRecord
  validates :description, presence: true
  
  scope :completed, -> { where(completed: true) }
  scope :pending,   -> { where(completed: false) }
end
