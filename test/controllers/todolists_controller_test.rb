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
    assert_difference("Todolist.count", 1) do
      post todolists_url, params: { todolist: { content: "งานใหม่", checklist: false } }
    end
    # ตรวจสอบทั้ง HTML และ Turbo Stream
    assert_response :redirect
    assert_redirected_to todolists_url
  end

  test "should update todolist" do
    patch todolist_url(@todolist), params: { todolist: { content: "แก้ไขงาน", checklist: true } }
    assert_response :redirect
    assert_redirected_to todolists_url

    @todolist.reload
    assert_equal "แก้ไขงาน", @todolist.content
    assert_equal true, @todolist.checklist
  end

  test "should destroy todolist" do
    assert_difference("Todolist.count", -1) do
      delete todolist_url(@todolist)
    end
    assert_response :redirect
    assert_redirected_to todolists_url
  end

  # เพิ่ม test สำหรับ RecordNotFound
  test "should redirect to root if record not found" do
    get todolist_url(id: "non-existent-id")
    assert_redirected_to root_path
  end
end
