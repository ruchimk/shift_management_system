
function ready() {
  $('#calendar').fullCalendar({

        })

  /* initialize the external events
  -----------------------------------------------------------------*/

  $('#external-events div.external-event').each(function() {

      // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
      // it doesn't need to have a start or end
      var eventObject = {
          title: $.trim($(this).text()) // use the element's text as the event title
      };

      // store the Event Object in the DOM element so we can get to it later
      $(this).data('eventObject', eventObject);

      // make the event draggable using jQuery UI
      $(this).draggable({
          zIndex: 999,
          revert: true,      // will cause the event to go back to its
          revertDuration: 0  //  original position after the drag
      });

  });

  $( ".fc-day" ).droppable({
     drop: function( event, ui ) {
        var copy = $(ui.draggable.context).clone().text(),
            shift = $("<p class='external-event' data-shift-time='"+copy+"'>"+copy+"</p>"),
            date = $( this );
        console.log($(".external-event[data-shift-time='"+copy+"']", this).length)
        if($(".external-event[data-shift-time='"+copy+"']", this).length == 0){
          date
             .addClass( "ui-state-highlight" )
               .append(shift);
             shift.click(function() {
               alert("Wanna request shift brah?")
             })
        }
      }

   });

  /* initialize the calendar
  -----------------------------------------------------------------*/

  $('#calendar').fullCalendar({
      header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month,agendaWeek,agendaDay'
      },
      editable: true,
      droppable: true, // this allows things to be dropped onto the calendar !!!
      drop: function(date, allDay) { // this function is called when something is dropped

          // retrieve the dropped element's stored Event Object
          var originalEventObject = $(this).data('eventObject');

          // we need to copy it, so that multiple events don't have a reference to the same object
          var copiedEventObject = $.extend({}, originalEventObject);

          // assign it the date that was reported
          copiedEventObject.start = date;
          copiedEventObject.allDay = allDay;

          // render the event on the calendar
          // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
          $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

          // is the "remove after drop" checkbox checked?
          if ($('#drop-remove').is(':checked')) {
              // if so, remove the element from the "Draggable Events" list
              $(this).remove();
          }

      }
  });
  
  $.getJSON("/assigned_shifts/"+userID+".json", function (data) {
    for (var i = 0, shiftLength = data.length, shift, shift_p; i < shiftLength; i++) {
      shift = data[i]
      shift_p = $("<p class='external-event' data-shift-time='"+shift.id+"'>" + shift.time_string + "</p>")
      $(".fc-day[data-date='"+shift.date+"']").append(shift_p)
    }
  })
}

$(document).ready(ready);
$(document).on('page:load', ready);
