#= require fullcalendar/lang-all

$ ->
  $('#calendar').fullCalendar(
      header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month,agendaWeek,agendaDay'
      },
      lang:'de'
      events: '/calendar_events.json'
      timeFormat: 'H(:mm)'
  );
