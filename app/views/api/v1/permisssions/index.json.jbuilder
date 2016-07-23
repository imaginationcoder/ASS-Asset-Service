json.asset_url @template.source.url
json.text_assets @template.text_assets do |asset|
  json.text asset.text
  json.position asset.position
end
json.button_actions @template.button_actions do |action|
  if action.btn_type.eql?(1) # Text
    json.label action.label
  elsif action.btn_type.eql?(2)  # image
    json.asset_url action.source.url
  end
  json.target_event action.target_event if action.target_event.present?
end