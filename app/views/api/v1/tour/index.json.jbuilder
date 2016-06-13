json.tour_name @tour.name
json.app_name @application.name
json.assets @tour.assets do |asset|
   json.asset_url asset.source.url
   json.heading asset.heading
   json.sub_text asset.sub_text
end

