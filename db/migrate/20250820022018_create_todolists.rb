class CreateTodolists < ActiveRecord::Migration[8.0]
  def change
    create_table :todolists do |t|
      t.string :content
      t.boolean :checklist

      t.timestamps
    end
  end
end
