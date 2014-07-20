(function() {
  var redirectTo = function(url) {
    $.pjax({url: url, container: '#container_content'});
  }

  // Pjax Setup
  $.pjax.defaults.timeout = 3000;
  $(document).pjax('a', '#container_content');

  // Nav Shortcuts
  Mousetrap.bind("g h", function() { redirectTo('/'); });
  Mousetrap.bind("g n", function() { redirectTo('/notes'); });
  Mousetrap.bind("g b", function() { redirectTo('/bliss_manifesto'); });
  Mousetrap.bind("g a", function() { redirectTo('/articles'); });
  Mousetrap.bind("g r", function() { redirectTo('/recipes'); });

  // So many options...
  Mousetrap.bind("g s", function() { redirectToSearch(); });
  Mousetrap.bind("s", function() { redirectToSearch(); });
  Mousetrap.bind("/", function() { redirectToSearch(); });

  // Scrolling Shortcuts
  Mousetrap.bind("g g", function() { window.scrollTo(0, 0); });
  Mousetrap.bind("G", function() { window.scrollTo(0, document.body.scrollHeight); });
  Mousetrap.bind("j", function() { window.scrollBy(0, 50); });
  Mousetrap.bind("k", function() { window.scrollBy(0, -50); });

  var redirectToSearch = function() {
    redirectTo('/search');
  }

  var submitSearch = function(event) {
    $.pjax.submit(event, "#container_content");
  }

  $(document).on("ready pjax:success", function() {
    // Fancy timestamps
    $("time.timeago").timeago();

    $("#mb-search-link").off("click", redirectToSearch);
    $("#mb-search-link").on("click", redirectToSearch);

    $("#mb-search-form").off("submit", submitSearch);
    $("#mb-search-form").on("submit", submitSearch);

    $("#mb-search-input").select();
  });
})();
