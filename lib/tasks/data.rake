require 'open-uri'

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

def create_index(table, id_field = 'id')
  data = read_xml(table)
  index = {}
  data.each do |item|
    index[ item[id_field] ] = item
  end
  index
end

def create_map(table, id_field = 'id')
  data = read_xml(table)
  index = {}
  data.each do |item|
    id = item[id_field].to_i
    index[ id ] ||= []
    index[ id ] << item
  end
  index
end

namespace :seed do
  desc "Seed existing data"
  task :projects => :environment do
    Project.destroy_all
    projects = read_xml('jtm_stuecke')
    projects.each do |project|
      m = create_model project, Project, id: 'id', title: 'titel', subtitle: 'untertitel', description: 'inhalt'
      puts m.inspect
    end
  end
  
  task :pictures => :environment do
    # Probleme:
    # 404 Forbidden: 115, 113, 112, 111, 109, 108
    # Bad Url (4 Stück): Aladin, TH Live 2005
    
    # ProjectFile.delete_all
    # si = create_index('jtm_stuecke')
    ppm = create_map('jtm_stueck_bilder', 'stueck_id')
    di = create_index('jtm_dokumente')
    puts ppm.length
    ppm.each do |index, items|
      p = Project.find(index.to_i)
      puts p.title
      items.each do |item|
        dokument = di[item['file_id']]
        puts " - #{dokument['pfad']} : #{dokument['beschreibung']}"
        
        file = dokument['pfad']
        url = "http://jtm.de/uploads/#{file}"
        file_name = File.basename(file)
        
        begin
          open url do |f|
            pf = p.project_files.create file: f, kind: 'image', description: dokument['beschreibung'], file_file_name: file_name
            puts pf.inspect
          end
        rescue Exception => e
          puts " - ERROR: #{url}  : #{e}"
        end
        
      end
    end
  end
  
  task :press => :environment do
    # ProjectFile.delete_all

    ppm = create_map('jtm_presse', 'projekt_id')
    di = create_index('jtm_dokumente')
    # puts ppm.length
    ppm.each do |index, items|
      if index == 0
        puts "\n---   NO Project: #{items.inspect}\n"
        next
      end
      p = Project.find(index)
      puts p.title
      items.each do |item|
        dokument = di[item['file_id']]
        datum = DateTime.strptime("#{dokument['timestamp']}",'%s')
        puts " - #{dokument['pfad']} : #{dokument['zeitung']}"
        
        file = dokument['pfad']
        url = "http://jtm.de/uploads/#{file}"
        file_name = File.basename(file)
        
        begin
          
          open url do |f|
            pf = p.project_files.create! file: f, kind: 'press', description: dokument['zeitung'], file_file_name: file_name, meta: {published_at: datum}
            # puts pf.inspect
          end
        rescue Exception => e
          puts " - ERROR: #{url}  : #{e}"
        end
        
      end
    end
  end

  task :groups => :environment do
    Group.destroy_all
    groups = read_xml('jtm_gruppen')
    groups.each do |group|
      puts group.inspect
      g = create_model group, Group, id: 'id', name: 'name', shortcut: 'kuerzel', public: 'extern_sichtbar'
      g.page.update_attributes content: group['beschreibung'], title: group['name']
      # g.page.save
    end
  end
  
  # task :test => :environment do
  #   p = Project.last
  #   file = 'projekte/94/oz1.jpg'
  #   file_name = File.basename(file)
  #   open "http://jtm.de/uploads/#{file}" do |f|
  #     pf = p.project_files.create file: f, kind: 'image', description: 'test', file_file_name: file_name
  #     puts pf.inspect
  #   end
  # end
  
end