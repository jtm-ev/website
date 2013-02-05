
def read_xml(table)
  data = Hash.from_xml File.read("data/#{table}.xml")
  data['th27_jtm'][table]
end

def create_model(data, klass, fields = {})
  m = klass.new
  fields.each do |key, value|
    m.send "#{key}=".to_sym, data[value]
  end
  m.save
  m
end

namespace :seed do
  desc "Seed existing data"
  task :projects => :environment do
    Project.delete_all
    projects = read_xml('jtm_stuecke')
    projects.each do |project|
      m = create_model project, Project, id: 'id', title: 'titel', subtitle: 'untertitel', description: 'inhalt'
      puts m.inspect
    end
  end
end