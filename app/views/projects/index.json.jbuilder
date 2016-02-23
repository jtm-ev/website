

json.projects @projects do |project|
  json.id project.id
  json.title project.title
  json.html_url "/projekte/#{project.id}"
end
