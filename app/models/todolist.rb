class Todolist < ApplicationRecord
  validates :content, presence: true
end
