class ChangeChecklistDefaultOnTodolists < ActiveRecord::Migration[8.0]
  def change
    change_column_default :todolists, :checklist, false
    Todolist.where(checklist: nil).update_all(checklist: false)
  end
end
