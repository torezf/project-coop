require "test_helper"

class TodolistTest < ActiveSupport::TestCase
  test "should not save todo without content" do
    todo = Todolist.new(checklist: false)
    assert_not todo.save
  end

  test "should save todo with content" do
    todo = Todolist.new(content: "My Todo", checklist: false)
    assert todo.save
  end
end
