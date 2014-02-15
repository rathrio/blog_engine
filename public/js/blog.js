$(document).ready(function() {
  // Init MagicBox search
  MBSearch.init();

  // Fancy timestamps
  $("time.timeago").timeago();

  // Nav Shortcuts
  Mousetrap.bind("g n", function() { window.location.href = "/notes" });
  Mousetrap.bind("g b", function() { window.location.href = "/bliss_manifesto" });
  Mousetrap.bind("g a", function() { window.location.href = "/articles" });
  Mousetrap.bind("g r", function() { window.location.href = "/recipes" });

  // Search Shortcuts
  Mousetrap.bind("/", function() { MBSearch.displaySearchOverlay() });
  Mousetrap.bind("esc", function() { MBSearch.hideSearchOverlay() });
});

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
