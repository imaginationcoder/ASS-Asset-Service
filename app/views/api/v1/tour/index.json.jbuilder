json.tour_name @tour.name
json.app_name @application.name
json.assets @tour.guides do |guide|
   json.asset_url guide.source.url
   json.heading guide.heading
   json.description guide.description
end

