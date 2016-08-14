$(document).ready(function() {
  var fixtureSpans = $('span.next-fixture-date');
  fixtureSpans.each(function() {
    var element = $(this);

    // var dateObject = new Date(element.text());

    // var hours = dateObject.getHours();
    // var minutes = dateObject.getMinutes();
    // // AM or PM
    // var period = hours < 12 ? "a" : "p"

    // element.text("(" + hours + ":" + minutes + period + ")")

    console.log(element.text());

    var momentObject = moment(new Date(element.text()));
    var newText = momentObject.format('h:mma').slice(0, -1);
    element.text("(" + newText + ")");

    element.show();
  })
});
