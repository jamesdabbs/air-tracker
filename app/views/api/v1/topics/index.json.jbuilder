json.array! @topics do |topic|
  json.(topic, :id, :title)
  json.url api_v1_topic_url(topic)
end
