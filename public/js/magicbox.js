$(document).ready(function() {
  // Init MagicBox search
  //MBSearch.init();

  // Nav Shortcuts
  Mousetrap.bind("g n", function() { $.pjax({url: "/notes", container: '#container_content'}) });
  Mousetrap.bind("g b", function() { $.pjax({url: "/bliss_manifesto", container: '#container_content'}) });
  Mousetrap.bind("g a", function() { $.pjax({url: "/articles", container: '#container_content'}) });
  Mousetrap.bind("g r", function() { $.pjax({url: "/recipes", container: '#container_content'}) });

  // Search Shortcuts
  Mousetrap.bind("/", function() { MBSearch.displaySearchOverlay() });
  Mousetrap.bind("esc", function() { MBSearch.hideSearchOverlay() });

  // Pjax Setup
  $(document).pjax('a', '#container_content');
});

$(document).on("ready pjax:success", function() {
  // Fancy timestamps
  $("time.timeago").timeago();
})

var MBSearch = function() {
  var searchOverlay;
  var searchInput;

  return {
    init: function() {
      searchOverlay = document.getElementById("search_overlay");
      searchInput = document.getElementById("search_input");
    },

    getSearchInputField: function() {
      return searchInput;
    },

    displaySearchOverlay: function() {
      searchOverlay.style.visibility = "visible";
    },

    hideSearchOverlay: function() {
      searchOverlay.style.visibility = "hidden";
    }
  }
}();
