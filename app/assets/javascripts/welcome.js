function makeDaysDroppable() {
  $( ".fc-day" ).not($(".fc-past")).droppable({
    hoverClass: "hoverStuff",
    refreshPositions: true, //added line
     drop: function( event, ui ) {
        var copy = $(ui.draggable.context).clone().text(),
            copyID = $(ui.draggable.context).data("shift-template-id")
            shift = $("<p class='external-event eventOnCalendar' data-template-id='"+copyID+"'>"+copy+"</p>"),
            date = $( this ),
            employeeID = $("#employeeID").val();
        if($(".external-event[data-template-id='"+copyID+"']", this).length == 0){
          date
             .addClass( "ui-state-highlight" )
               .append(shift);
             shift.click(function() {
               this_div = $(this)
               $('#requestBox').show()
               requestHeader = "Shift Change for " + this_div.text() + " on " + this_div.parent().data('date')
               $('.request_header').text(requestHeader)
               $("#request_shift_id").val($(this).data("id"))
             })
        }
        $.post("/assign_shift", {shift: {employee_id:employeeID, date:date.data('date'), shift_template_id:copyID}}, function(data){
        })
      }


   });
}
function approveRequest(id, element) {
  event.stopPropagation();

  $.post("/approve_request",{id: id, admin_id:userID}, function (data) {console.log(data)})

  $(element).parent().fadeOut()
}

function denyRequest(id, element) {
  event.stopPropagation();

  $.post("/deny_request",{id: id, admin_id:userID}, function (data) {console.log(data)})

  $(element).parent().fadeOut()
}

function showShiftForm() {
  $(".shiftTemplateForm").slideDown("slow")
  $("#newShift").hide();
}

function cancelCreateShift() {
  $(".shiftTemplateForm").hide()
  $("#newShift").fadeIn("slow")
}
function createShift() {
  var startTime = $('#shiftTempStartTime').val(),
      endTime = $('#shiftTempEndTime').val();
  $.post("/create_shift_template", {shift_template: {start_time:startTime, end_time:endTime, company_id:companyID}}, function(data) {
    var shiftTempDiv = $("<div class='external-event' data-shift-template-id="+data.shiftTemplate.id+">"+data.timeString+"</div>");

    $('.shiftTemplatesList').append(shiftTempDiv)
  })
  $(".shiftTemplateForm").hide()
  $("#newShift").fadeIn("slow")
}

function getEmployeeShifts(employeeID) {
  $.getJSON("/assigned_shifts/"+employeeID+".json", function (data) {
    for (var i = 0, shiftLength = data.length, shift, shift_p, requestHeader; i < shiftLength; i++) {
      shift = data[i]
      shift_div = $("<div class='external-event eventOnCalendar' data-id="+shift.id+" data-template-id="+shift.shift_template_id+">" + shift.time_string + "</div>")
      $(".fc-day[data-date='"+shift.date+"']").append(shift_div)
      shift_div.click(function() {
        this_div = $(this)
        $('#requestBox').fadeIn("slow")
        requestHeader = "Shift Change for " + this_div.text() + " on " + this_div.parent().data('date')
        $('.request_header').text(requestHeader)
        $("#request_shift_id").val($(this).data("id"))
      })
    }
  })
}                         

function ready() {
  $(".employeeID").each(function() {
    if (this.value == userID) {
      $(this).parent().addClass("activeEmployee")
    }
  })
  $('.hasPendingRequest').click(function () {
    var notifier = $('.employeeRequestNotifier', this),
        requests = $('.employeeRequests', this);
    $('.employeeRequests').not(requests).hide()
    $('.employeeRequestNotifier').not(notifier).fadeIn()
    if (notifier.is(":visible")) {
      notifier.hide()
      requests.fadeIn()
    } else {
      notifier.fadeIn()
      requests.hide()
    }
  })

  $('.employee').click(function () {
    var this_div = $( this )
    $(".employee").not(this).removeClass("activeEmployee")
    if (!this_div.hasClass( "hasPendingRequest" )){
      $('.employeeRequests').hide()
      $('.employeeRequestNotifier').fadeIn()
    }
    this_div.addClass("activeEmployee")
    $(".eventOnCalendar").remove()
    employeeID = $(".employeeID", this).val()
    $("#employeeID").val(employeeID)
    getEmployeeShifts(employeeID)
  })

  

  $('#calendar').fullCalendar()

  $(".fc-button").click(function() {
    employeeID = $("#employeeID").val()
    getEmployeeShifts(employeeID)
    makeDaysDroppable()
  })
  $(".fc-day").click(function () {
    if (($(".eventOnCalendar", this).length == 0)) {
      var this_element = $(this),
          date = new Date(this_element.data('date'))
          date.setHours( date.getHours() + 6 )
      $("#availabilityBox").fadeIn()
      $(".availabilityDate").val(this_element.data('date'))
      availability_header = "Create availability on " + date.toLocaleDateString("en-US")
      $('.availability_header').text(availability_header)
      $("#availability_shift_id").val($(this).data("id"))
    }
  })
  /* initialize the external events
  -----------------------------------------------------------------*/
  $('.shiftTemplatesList .external-event').mousedown(function () {
    // $(this).css("zoom",1)
    // $(this).removeClass("external-event")
  })
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

  makeDaysDroppable()
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

  getEmployeeShifts(userID)

}

function populateRequestChange (data) {
  alert($(data).data("id"))
}
$(document).ready(ready);
$(document).on('page:load', ready);
