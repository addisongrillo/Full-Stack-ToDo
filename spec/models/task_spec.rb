require "rails_helper"

RSpec.describe Task, type: :model do
  describe ".completed" do
    it "returns only completed tasks" do
      completed = Task.create(description: "completed", completed: true)
      incomplete = Task.create(description: "incomplete", completed: false)

      expect(Task.completed).to match_array([completed])
    end
  end
  describe ".pending" do
    it "returns only pending tasks" do
      completed = Task.create(description: "completed", completed: true)
      incomplete = Task.create(description: "incomplete", completed: false)

      expect(Task.pending).to match_array([incomplete])
    end
  end
end
