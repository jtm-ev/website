

json.array! @projects do |project|
  json.extract! project, :id, :description, :title
end
