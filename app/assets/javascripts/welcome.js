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

    element.removeClass('next-fixture-date');
    element.show();
  });
};

var toggleHeads = function() {

  $('div.owner-heads').hover(function() {
    $(this).css('cursor', 'pointer');
    $(this).addClass('highlight');
  }, function() {
    $(this).removeClass('highlight');
  });

  $('div.sidebets-owners-wrapper').on('click', 'div.sidebets-heads-clickable', function() {
    $(this).children('div.heads-hidden').toggle();
  });
};


$(document).ready(function() {
  formatMatchTimes();
  toggleDashboard();
  toggleHeads();
  disableLinks();
  confirmAvatarChange();
  toggleAvatarForm();

  loadFixtures();
});


// Use for re-activating Turbolinks.
// $(document).on('page:load', main);
// $(document).on('turbolinks:load', main);
