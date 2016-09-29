json.array!(@calendar_events) do |calendar_event|
  json.extract! calendar_event, :id, :title, :description
  json.start calendar_event.start_time
  json.end calendar_event.end_time
  json.url calendar_event_url(calendar_event, format: :html)
end
