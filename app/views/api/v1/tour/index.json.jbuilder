json.tour do
  json.prompts @tour_prompts do |prompt|
    json.header prompt.header
    json.footer prompt.footer
    json.content prompt.content
    json.content_position prompt.content_position
    json.asset_url prompt.source.url
    json.button_actions prompt.button_actions do |bc|
      json.btn_text bc.btn_text
      json.asset_url bc.source.url
    end
  end
end
