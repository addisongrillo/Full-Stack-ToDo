class Task < ApplicationRecord
  has_many :sub_tasks, dependent: :destroy

  validates :description, presence: true

  scope :completed, -> { where(completed: true) }
  scope :pending,   -> { where(completed: false) }
end
