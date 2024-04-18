json.extract! webhook, :id, :source, :data, :message, :event, :created_at, :updated_at
json.url webhook_url(webhook, format: :json)
