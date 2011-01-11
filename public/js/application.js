
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
