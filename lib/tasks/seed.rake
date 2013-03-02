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

def find_member(name, first_name)
  full_name = [name, first_name].join ' '
  
  if name.blank? or first_name.blank?
    puts "ERROR: NO PERSON: #{full_name}"
    return nil
  end

  # mm = Member.where(name: name, first_name: first_name).or.where(birth_name: name, first_name: first_name)
  mm = Member.where("first_name = ? AND (name = ? or birth_name = ? )", first_name, name, name)
  
  if mm.count > 1
    puts "ERROR: More : #{full_name}"
    raise "More People"
  elsif mm.count == 0
    return Member.create name: name, first_name: first_name, active: false

    # alt = Member.where(first_name: first_name, gender: 'w')
    # if alt.count > 0
    #   puts "\nChoose Member for: #{full_name}"
    #   # puts " - #{alt.count} '#{first_name}' found"
    #   alts = alt.to_a
    #   alts.each_with_index do |a, i|
    #     puts " #{i + 1}) : #{a.name} #{a.first_name}"
    #   end
    #   
    #   inp = STDIN.gets.chomp.to_i
    #   if inp == 0
    #     return Member.create name: name, first_name: first_name, active: false
    #   else
    #     # apply birth_name
    #     m = alts[inp - 1]
    #     m.update_attributes birth_name: name
    #     return m
    #   end
    # else
    #   # puts "ERROR: NOTHING FOUND"
    #   return Member.create name: name, first_name: first_name, active: false
    # end
  else
    return mm.first
  end
  
  nil
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
  
  task :events => :environment do
    Event.delete_all
    em = create_map('jtm_stueck_termine', 'stueck_id')
    em.each do |index, items|
      p = Project.find(index.to_i)
      puts "Project: #{p.title}"
      items.each do |t|
        ort, timestamp, zusatz = t['ort'], t['timestamp'], t['zusatz']
        datum = DateTime.strptime("#{timestamp}",'%s')
        p.events.create title: zusatz, location_name: ort, start_time: datum
      end
    end
  end
  
  task :event_locations => :environment do
    pfarrheim = Location.find_or_create_by_name('Pfarrheim Martinszell')
    mzh = Location.find_or_create_by_name('Mehrzweckhalle Oberdorf')
    studio = Location.find_or_create_by_name('Studiotheater')
    theatrium = Location.find_or_create_by_name('Theatrium')
    
    map = {
      'Pfarrheim in Martinszell' => pfarrheim,
      'Sporthalle Oberdorf' => mzh,
      'Sporthalle Oberdorf, Studiotheater' => studio,
      'Mehrzweckhalle Oberdorf' => mzh,
      'Studiotheater Mehrzweckhalle Oberdorf' => studio,
      'MZH Oberdorf' => mzh,
      'Pausenhof an der neuen Schule' => theatrium,
      'Studiotheater' => studio,
      'Theatrium' => theatrium,
      'Pausenhof Grundschule' => theatrium,
      'Pausenhof Grundschule Oberdorf' => theatrium,
      'Pausenhof - Grundschule' => theatrium,
      'Studiotheater MZH Oberdorf' => studio
    }
    Event.all.group_by(&:location_name).each do |location_name, events|
      puts "#{location_name} : #{events.count}"
      location = map[location_name]
      if location
        events.each do |event|
          event.location = location
          event.save
        end
      end
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
      next unless p.id == 125
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
      next unless p.id == 125
      puts p.title
      items.each do |item|
        dokument = di[item['file_id']]
        datum = DateTime.strptime("#{item['timestamp']}",'%s')
        zeitung = item['zeitung']
        puts " - #{zeitung} : #{datum} : #{dokument['pfad']}"
        
        file = dokument['pfad']
        url = "http://jtm.de/uploads/#{file}"
        file_name = File.basename(file)
        
        begin
          
          open url do |f|
            pf = p.project_files.create! file: f, kind: 'press', description: zeitung, file_file_name: file_name, meta: {published_at: datum}
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
    gm = create_map('jtm_gruppen_mitglieder', 'gruppe_id')
    groups.each do |group|
      puts group.inspect
      g = create_model group, Group, id: 'id', name: 'name', shortcut: 'kuerzel', public: 'extern_sichtbar'
      g.page.update_attributes content: group['beschreibung'], title: group['name']
      if gm[g.id]
        gm[g.id].each do |items|
          mid = items['mitglied_id']
          g.group_memberships.create member: Member.find(mid)
        end
      end
    end
  end
  
  task :members => :environment do
    Member.destroy_all
    members = read_xml('jtm_mitglieder')
    members.each do |member|
      puts [member['nachname'], member['vorname']].join ' '
      m = create_model member, Member, id: 'id', name: 'nachname', first_name: 'vorname', street: 'strasse', city: 'wohnort', phone: 'telefon', fax: 'fax', mobile: 'handy', email: 'email', email_extern: 'email_extern', school: 'klasse', gender: 'geschlecht'
      birthday = Date.strptime(member['geburtsdatum'], "%Y-%m-%d")
      member_since = Date.strptime(member['mitglied_seit'], "%Y-%m-%d")
      m.update_attributes birthday: birthday, member_since: member_since
    end
  end
  
  task :teams => :environment do
    akts = read_xml('jtm_stueck_akteure')
    team_index = create_index('jtm_stueck_akteur_bereiche')
    akts.each do |akt|
      p = Project.find akt['stueck_id'].to_i
      team_name = team_index[ akt['bereich_id'] ]['name']
      team = p.teams.find_or_create_by_name(team_name)
      
      m = find_member akt['nachname'], akt['vorname']
      if m
        team.team_memberships.create member: m, role: akt['figur']
      end
      # puts [p.title, team_name, team.id, nachname, vorname].join ' : '
      
    end
    
    puts "\nTeams: #{Team.count} TeamMembers: #{TeamMembership.count}"
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