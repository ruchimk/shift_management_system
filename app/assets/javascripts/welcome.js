
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
            copyID = $(ui.draggable.context).data("shift-template-id")
            shift = $("<p class='external-event eventOnCalendar' data-template-id='"+copyID+"'>"+copy+"</p>"),
            date = $( this );
        if($(".external-event[data-template-id='"+copyID+"']", this).length == 0){
          date
             .addClass( "ui-state-highlight" )
               .append(shift);
             shift.click(function() {
               alert("Wanna request shift brah?")
             })
        }
        $.post("/assign_shift", {shift: {employee_id:userID, date:date.data('date'), shift_template_id:copyID}}, function(data){
          console.log(data)
        })
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
    for (var i = 0, shiftLength = data.length, shift, shift_p, requestHeader; i < shiftLength; i++) {
      shift = data[i]
      shift_div = $("<div class='external-event eventOnCalendar' data-id='"+shift.id+"'>" + shift.time_string + "</div>")
      $(".fc-day[data-date='"+shift.date+"']").append(shift_div)
      shift_div.click(function() {
        this_div = $(this)
        $('#requestBox').show()
        requestHeader = "Shift Change for " + this_div.text() + " on " + this_div.parent().data('date')
        $('.request_header').text(requestHeader)
        $("#request_shift_id").val($(this).data("id"))
      })
    }
  })
}

function populateRequestChange (data) {
  alert($(data).data("id"))
}
$(document).ready(ready);
$(document).on('page:load', ready);
