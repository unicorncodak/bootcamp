json.extract! task, :id, :project_id, :user_id, :title, :created_at, :updated_at
json.url task_url(task, format: :json)
