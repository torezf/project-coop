json.extract! todolist, :id, :content, :checklist, :created_at, :updated_at
json.url todolist_url(todolist, format: :json)
