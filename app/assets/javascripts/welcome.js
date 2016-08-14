var formatMatchTimes = function() {
  var fixtureSpans = $('span.next-fixture-date');
  fixtureSpans.each(function() {
    var element = $(this);
    var dateObject = new Date(parseInt(element.text()));

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

    element.text("(" + hours + ":" + minutes + period + ")");

    // moment.js ...which isn't working on mobile/Safari
    // var momentObject = moment(new Date(element.text()));
    // var newText = momentObject.format('h:mma').slice(0, -1);
    // element.text("(" + newText + ")");

    element.show();
  });
};

var toggleAvatarForm = function() {
  $('div.change-avatar').on('click', 'button', function() {
    $('div.change-avatar-form').toggle();
  });
};

var disableLinks = function() {
  if (window.location.pathname !== "/") {
    $('div.owner-name a').attr('href', '/');
  };
};

// $(document).ready(main);

$(document).ready(function() {
  formatMatchTimes();
  toggleAvatarForm();
  disableLinks();
});


// I frankly don't even know which of these is supposed to work.
// $(document).on('page:load', main);
// $(document).on('turbolinks:load', main);
