$(document).ready(function() {
  var fixtureSpans = $('span.next-fixture-date');
  fixtureSpans.each(function() {
    var element = $(this);

    var dateObject = new Date(element.text());

    var hours = dateObject.getHours();

    var minutes = dateObject.getMinutes();
    if (minutes === 0) {
      minutes = "00"
    }

    // set AM or PM...
    var period = hours < 12 ? "a" : "p"
    // ...then change to 12-hour format
    if (hours > 12) {
      hours = hours -12
    }

    element.text("(" + hours + ":" + minutes + period + ")")

    // moment.js ...which isn't working on mobile/Safari
    // var momentObject = moment(new Date(element.text()));
    // var newText = momentObject.format('h:mma').slice(0, -1);
    // element.text("(" + newText + ")");

    element.show();
  })
});
