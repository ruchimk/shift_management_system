function readyReport() {
  $(".employeeReport").click(function(){
    var this_div = $( this )
    this_div.addClass("activeEmployee")
    $(".employeeReport").not(this).removeClass("activeEmployee")
    employeeID = $(".employeeID", this).val()
    $("#employeeID").val(employeeID)
    $.get("/userReport/"+employeeID, function(data) {
      $(".userreports").html(data)
    })    

  })
}
$(document).ready(readyReport);
$(document).on('page:load', readyReport);