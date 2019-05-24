class Task < ApplicationRecord
  has_many :sub_tasks, dependent: :destroy

  validates :description, presence: true

  scope :completed, -> { where(completed: true) }
  scope :pending,   -> { where(completed: false) }
  scope :ordered,   -> { order(due_date: :asc) }

  def due_date_class
    if due_date.nil?
      "due_date"
    elsif due_date < Date.today
      "due_date badge badge-danger"
    elsif due_date < 1.week.from_now.to_date
      "due_date badge badge-warning"
    else
      "due_date badge badge-success"
    end
  end
end
