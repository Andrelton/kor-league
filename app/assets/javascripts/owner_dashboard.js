var loadFixtures = function() {
  $('div.schedule-wrapper').on('click', 'a.trigger-dashboard-fixtures', function(event) {
    event.preventDefault();

    $('div.dashboard-loading').show();

  });
};
