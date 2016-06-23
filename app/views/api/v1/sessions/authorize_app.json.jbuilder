json.application do
  json.id @application.id.to_s
  json.name @application.name
  json.expires_at @application.expires_at.to_i
  json.description @application.description
  json.sw_version @application.sw_version
end