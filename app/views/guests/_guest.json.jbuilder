json.extract! guest, :id, :name, :email, :telephone, :kinship, :table, :created_at, :updated_at
json.url guest_url(guest, format: :json)
