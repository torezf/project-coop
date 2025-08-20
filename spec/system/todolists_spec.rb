# spec/system/todolists_spec.rb

require "rails_helper"

RSpec.describe "Todolists", type: :system do
  before do
    driven_by(:selenium_chrome_headless)

    @todolist = Todolist.create!(content: "อ่านหนังสือ", checklist: false)
  end

  it "shows profile and todolist" do
    visit root_path
    expect(page).to have_content("MY PROFILE")
    expect(page).to have_content("Prakit")
    expect(page).to have_content("TODO LIST")
    expect(page).to have_selector("input[placeholder='Type something .....']")
    expect(page).to have_content("อ่านหนังสือ")
  end

  it "can create a todolist" do
    visit root_path
    within("form[action='#{todolists_path}']") do
      fill_in "Type something .....", with: "ออกกำลังกาย"
      find("button[type=submit]").click
    end
    expect(page).to have_content("ออกกำลังกาย")
  end

  it "can mark checklist of a todolist" do
    visit root_path
    within(:xpath, "//li[contains(., 'อ่านหนังสือ')]") do
      click_button "✅"
    end

    li = find('li', text: "อ่านหนังสือ")
    expect(li[:class]).to include("line-through")
    expect(li[:class]).to include("opacity-70")
  end

  it "can delete a todolist" do
    visit root_path
    within(:xpath, "//li[contains(., 'อ่านหนังสือ')]") do
      click_button "❌"
    end

    expect(page).not_to have_content("อ่านหนังสือ")
  end

  it "can navigate to My Brag Document page" do
    visit root_path
    click_link "My Brag Document"
    expect(current_path).to eq(brag_path)
    expect(page).to have_content("BRAG DOCUMENT")
  end
end
