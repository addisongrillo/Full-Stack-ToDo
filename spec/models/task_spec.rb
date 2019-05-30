require "rails_helper"

RSpec.describe Task, type: :model do
  let(:user){ User.create(email: "some@guy.com", password: "password") }
  describe ".completed" do
    it "returns only completed tasks" do
      completed = Task.create(description: "completed", completed: true, user: user)
      incomplete = Task.create(description: "incomplete", completed: false, user: user)

      expect(Task.completed).to match_array([completed])
    end
  end
  describe ".pending" do
    it "returns only pending tasks" do
      completed = Task.create(description: "completed", completed: true, user: user)
      incomplete = Task.create(description: "incomplete", completed: false, user: user)

      expect(Task.pending).to match_array([incomplete])
    end
  end
end
