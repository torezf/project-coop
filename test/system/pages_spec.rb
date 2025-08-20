require "rails_helper"

RSpec.describe "Brag Document", type: :system do
  before do
    driven_by(:selenium_chrome)
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
    sleep 0.5
    expect(current_path).to eq(root_path)
  end
end
