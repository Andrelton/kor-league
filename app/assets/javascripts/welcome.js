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
    element.removeClass('next-fixture-date');
    element.show();
  });
};

var toggleDashboard = function() {
  $('div.dashboard-outer').on('click', 'button.show-dashboard', function() {
    $('div.dashboard').toggle();
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

var disableLinks = function() {
  if (window.location.pathname !== "/") {
    $('div.owner-name a').attr('href', '/');
  };
};

var confirmAvatarChange = function() {
  $('div.change-avatar').on('click', 'input[type=submit]', function(event) {
    event.preventDefault();

    // Old, simple confirmation:
    // if (confirm("Do you really want to change this avatar?")) {
    //   $(this).parent('form').submit();
    // };

    var ownerName = $('div.owner-name a').text();
    var password = prompt("Are you really " + ownerName + "? Enter password to continue.")

    // Wow! If you're reading this, you're a real sleuth,
    //   you've cracked the password. This was added as a
    //   stop-gap while a more comprehensive plan for a user
    //   model is planned.
    // So please, if you shouldn't be reading this, be nice and
    //   don't change our silly pictures. Thanks!
    if (password == "Rochester") {
      $(this).parent('form').submit();
    } else {
      alert("Password invalid. If you are really " + ownerName + ", please contact your league organizer for assistance.");
    };
  });
};

var toggleAvatarForm = function() {
  $('div.change-avatar').on('click', 'a.change-avatar', function(event) {
    event.preventDefault();
    var form = $('div.change-avatar-form');
    if (form.css('visibility') === 'hidden') {
      form.css('visibility', 'visible')
    } else {
      form.css('visibility', 'hidden')
    };
  })
};

var avatarChangePassword = function() {

};

// $(document).ready(main);

$(document).ready(function() {
  formatMatchTimes();
  toggleDashboard();
  toggleHeads();
  disableLinks();
  confirmAvatarChange();
  toggleAvatarForm();

  loadFixtures();
});


// I frankly don't even know which of these is supposed to work.
// $(document).on('page:load', main);
// $(document).on('turbolinks:load', main);
