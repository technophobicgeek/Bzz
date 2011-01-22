
function dummyFunction(){}

function sendPulse() {
  $.ajax({
    url: '/app/Session/send_pulse'
  });
}

function setIntensity(intensity) {
  $.ajax({
    url: '/app/Session/set_intensity',
    data: {'cmd' : intensity}
  });
}

function turnOff() {
  $.ajax({
    url: '/app/Session/turn_off'
  });
}


$(document).ready(function(){
   var buttons = $('#controls .controlpanelButton');
   buttons.bind('click',function(){
      buttons.removeClass('active');
      $(this).addClass('active');
   });
});


$(document).ready(function(){
   var buttons = $('#controls .pulseButton');
   buttons.bind('click',function(){
      var $e = $(this);
      buttons.removeClass('active');
      $e.addClass('active');
      setTimeout(function() {
          buttons.removeClass('active');
        }, 1000 );
      });
});
