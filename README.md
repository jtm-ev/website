# JTM Website

## Fehlende Thumbnails der Bilder generieren
	rake paperclip:refresh:missing_styles

## Daten aus alter DB importieren
	rake seed:projects
	rake seed:groups
	
### Bilder importieren, Achtung! ImageMagick muss installiert sein, dauert sehr lang
	rake seed:pictures
	rake seed:press

## Rails Server Starten
Git Shell öffnen und dann:

	cd website
	bundle
	rake db:migrate
	rails s



## ImageMagick für Bildgenerierung
- Ghostscript: http://www.ghostscript.com/download/gsdnld.html
- ImageMagick: http://www.imagemagick.org/script/binary-releases.php#windows



## Programmierung

- Projekte
	- Termine
	- Akteure
	- Presse
	- Bilder, Slideshow
	- Multimedia-Inhalte, Videos, YouTube, YouTube-Channel
	- Soundtrack? vielleicht als YouTube-Playlist?
	- Dateien, Infomaterial, Programmheft als PDF, Flyer, ...
	- Tagging?  #Märchen, #J2, #Jubiläumsstück
- Interne Projekte, Events (wie z.B. Ausflüge, Backstage-Material von Stücken, ShowBühnchen?)
	- Gibt es zu jedem 'normalen' Projekt ein internes? Mit Verantwortlichem, Verteilern, ...
	- Aber es sollte auch rein interne Projekte geben

- Spielorte, Locations (haben Bilder, Anfahrtskizze, Info über Ausstattung, können mit Termin verknüpft werden?)



- Benutzerverwaltung, Rechte-Management

- Mitgliederverwaltung
- Gruppenverwaltung
- Termine
- Gästebuch
- Interner E-Mail Verteiler
- Projektbezogene E-Mail Verteiler, Gruppen

- Statische Seiten (Kontakt, Sponsoren, Der Verein, JTM-Hilft, die Gruppen?, Technik, ...)
- Startseite
- Blog?, Archiv
- Interner Blog?

- Integration Karten VVK?


## Design
- Externe Erscheinung
- Intern vielleicht einfach Twitter-Bootstrap, einfaches Design?
- Mobile Version? iPad, Handy (Stichwort 'Responsive Design')