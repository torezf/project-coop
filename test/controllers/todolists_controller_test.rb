require "test_helper"

class TodolistsControllerTest < ActionDispatch::IntegrationTest
  fixtures :todolists

  setup do
    @todolist = todolists(:one)
  end

  test "should get index" do
    get todolists_url
    assert_response :success
  end

  test "should create todolist" do
    assert_difference("Todolist.count") do
      post todolists_url, params: { todolist: { content: "งานใหม่", checklist: false } }
    end
    assert_redirected_to todolists_url
    assert_equal "Todolist was successfully created.", flash[:notice]
  end

  test "should update todolist" do
    patch todolist_url(@todolist), params: { todolist: { content: "แก้ไขงาน", checklist: true } }
    assert_redirected_to todolists_url
    assert_equal "Todolist was successfully updated.", flash[:notice]
    @todolist.reload
    assert_equal "แก้ไขงาน", @todolist.content
    assert_equal true, @todolist.checklist
  end

  test "should destroy todolist" do
    assert_difference("Todolist.count", -1) do
      delete todolist_url(@todolist)
    end
    assert_redirected_to todolists_url
    assert_equal "Todolist was successfully destroyed.", flash[:notice]
  end
end
