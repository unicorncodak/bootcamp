json.extract! team, :id, :project_id, :user_id, :read, :write, :update, :delete, :created_at, :updated_at
json.url team_url(team, format: :json)
