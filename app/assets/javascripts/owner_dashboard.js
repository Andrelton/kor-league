var toggleDashboard = function() {
  $('div.dashboard-outer').on('click', 'button.show-dashboard', function() {
    $('div.dashboard').toggle();
  });
};

var loadFixtures = function() {
  $('div.schedule-wrapper').on('click', 'a.trigger-dashboard-fixtures', function(event) {
    event.preventDefault();

    var loadingArea = $('div.dashboard-loading');
    loadingArea.show();

    var fixturesArea = $('div.dashboard-fixtures');
    var ownerID = $(this).attr('data-owner_id');

    var request = $.ajax({
      method: 'GET',
      url: '/async_fixtures',
      data: { owner_id: ownerID },
      dataType: 'html'
    });

    request.done(function(response) {
      loadingArea.hide();

      fixturesArea.html(response);
      formatMatchTimes();
      fixturesArea.show();
    });

  });
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

var disableLinks = function() {
  if (window.location.pathname !== "/") {
    $('div.owner-name a').attr('href', '/');
  };
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
