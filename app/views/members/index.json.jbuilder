json.array!(@members) do |member|
  json.extract! member, :studentid, :name, :email, :paid
  json.url member_url(member, format: :json)
end
