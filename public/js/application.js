
function dummyFunction(){}

function sendMessage(msg) {

  $.ajax({
    url: '/app/Session/send_message',
    data: {'cmd' : msg},
    success: function(data) {
        // $('.result').html(data);
    }
  });
}