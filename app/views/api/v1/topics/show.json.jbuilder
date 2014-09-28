json.(@topic, :id, :title, :description, :created_at, :score)

if @topic.scheduled_for
  json.(@topic, :scheduled_for, :meetup_url)
end

json.url api_v1_topic_url(@topic)
