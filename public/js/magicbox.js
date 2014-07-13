(function() {
  var redirectTo = function(url) {
    $.pjax({url: url, container: '#container_content'});
  }

  // Pjax Setup
  $(document).pjax('a', '#container_content');

  // Nav Shortcuts
  Mousetrap.bind("g n", function() { redirectTo('/notes'); });
  Mousetrap.bind("g b", function() { redirectTo('/bliss_manifesto'); });
  Mousetrap.bind("g a", function() { redirectTo('/articles'); });
  Mousetrap.bind("g r", function() { redirectTo('/recipes'); });

  // Search Shortcuts
  Mousetrap.bind("/", function() { MBSearch.displaySearchOverlay() });
  Mousetrap.bind("esc", function() { MBSearch.hideSearchOverlay() });

  $(document).on("ready pjax:success", function() {
    // Fancy timestamps
    $("time.timeago").timeago();
  })
})();
