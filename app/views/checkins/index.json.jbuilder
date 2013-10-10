json.array!(@checkins) do |checkin|
  json.extract! checkin, :studentid, :date
  json.url checkin_url(checkin, format: :json)
end
