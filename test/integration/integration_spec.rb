require "rails_helper"

RSpec.describe "Profile Integration", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
    @todolist = Todolist.create!(content: "อ่านหนังสือ", checklist: false)

  end

  it "shows the Brag Document page with all content" do
    visit brag_path

    expect(page).to have_link("BACK", href: root_path)

    expect(page).to have_content("BRAG DOCUMENT")

    expect(page).to have_content("Prakit")
    expect(page).to have_content("Aroonkitcharoen")
    expect(page).to have_content("TOR")

    within("div.bg-gray-900") do
      expect(page).to have_content("เป้าหมายในปี 2025")
      expect(page).to have_content("สามารถใช้ภาษาอังกฤษในการอ่านได้อย่างคล่องแคล่ว และพูดได้")
      expect(page).to have_content("Codewar คะแนน ≥ 400")
    end

    within("div.bg-gray-900") do
      expect(page).to have_content("Action ที่ให้ไปถึง")
      expect(page).to have_content("มีการเรียน Youtube วันละ 1 ep")
      expect(page).to have_content("ฝึก Codewar ทุกวัน วันละ 1 ข้อ")
    end
  end

  it "can navigate back to root page" do
    visit brag_path

    click_link "BACK"
    expect(current_path).to eq(root_path)
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

    li = find("li", text: "อ่านหนังสือ")
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
