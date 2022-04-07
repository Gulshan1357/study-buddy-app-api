json.extract! meeting, :id, :starts_at, :ends_at, :first_user_id, :second_user_id, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
