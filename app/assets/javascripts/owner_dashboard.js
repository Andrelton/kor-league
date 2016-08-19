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
