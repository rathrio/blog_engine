$(document).ready(function() {
  // Fancy timestamps
  $("time.timeago").timeago();

  // Shortcuts
  Mousetrap.bind("g n", function() { window.location.href = "/notes" });
  Mousetrap.bind("g b", function() { window.location.href = "/bliss_manifesto" });
  Mousetrap.bind("g a", function() { window.location.href = "/articles" });
  Mousetrap.bind("g r", function() { window.location.href = "/recipes" });
});
